From: Ryne Everett <ryneeverett@gmail.com>
Subject: Re: Fsck configurations and cloning.
Date: Sun, 6 Mar 2016 10:31:55 -0500
Message-ID: <CAGbFckZ_Hf6CzXpewAUEHrnb570pNbkU2CqQkaHj23uCATavrQ@mail.gmail.com>
References: <CAGbFckZNpy=2P8kpSsEpCeTFmgzE5MEK7fnS8xJzDSPJs3iJdQ@mail.gmail.com>
	<CA+P7+xozN8Ah9b1QxBFXEiO3=SsUq9J1r+XM5387AodfvXwRQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 16:32:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acaf3-0008K3-TF
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 16:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbcCFPb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 10:31:57 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34840 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbcCFPb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 10:31:57 -0500
Received: by mail-wm0-f52.google.com with SMTP id l68so53628607wml.0
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=AxcZ+9pfP329c28PObwBLDPID37p5OFcqSKs3/ZHJec=;
        b=pA3QMyWz2MRi07vUtMke6J57ZcjVDB5SUS4e7qqW9d9wfd/0avrVedL6VtTUYy6pKk
         8/vNaLOZUa9HhGIHJySnUbPDA2kNgJB/nGDvakVQQTC+FnoDVuoXNFYCdP41fit1qHD3
         BD5MMTClB4BG1MT3JAgSmOIOs5KUx3zDDRXUYFfAatSI/HC8DXrvYKqTgzNwsqAkkyCb
         tUqx94Mt/OmTHd3kJ1Q8hwvtmVb3fc/NWnPXK+oYGKnAujoKANTkW5roQEhNEvwcVg+l
         lslE9fhw4+b6TRAtj/brwKKBIhINev15u1WTvikbGMm7OEJESooBulMtpkYTw9MutkFj
         OFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=AxcZ+9pfP329c28PObwBLDPID37p5OFcqSKs3/ZHJec=;
        b=G48xI/jvAYp5t+DVto/n2UtJDx5yZ9kdXU2Xs09BBZ3PYkym3xGKdt4IGmsZTey1Ij
         sGl5oL4cJsdzaPHbDNspJZhlCk775pr4TGiClanGV5q5yoIFWd/QHLpnwYjbFwnqR/a6
         6beyINPyJDcbLKPCzTNwHy//Up1Zz67NkP2MAh5yvbUoVAwf2IOUaWOKhHFG86mdHD5X
         yhstWkd34v1DVVgRdF8rijdx3GKXThy53+W62lsiNfXzkUbCkIWGJgn+tGsef76hD5dN
         i0yb0JcKJsN2oQsoEu7VfDireGHdYyJnRRYlJVgvYaQ+dpSsaUWwGyLH4ezGkaM0aqRU
         +xqg==
X-Gm-Message-State: AD7BkJJGY40elqQN8/2ujENBXbtD7zMpbOWAMu0eYrwbRzeox3c1GOw3z5g1CW93zjQRUVTKWJQlwV9GA9J7wA==
X-Received: by 10.28.156.199 with SMTP id f190mr8032716wme.83.1457278315466;
 Sun, 06 Mar 2016 07:31:55 -0800 (PST)
Received: by 10.28.16.15 with HTTP; Sun, 6 Mar 2016 07:31:55 -0800 (PST)
In-Reply-To: <CA+P7+xozN8Ah9b1QxBFXEiO3=SsUq9J1r+XM5387AodfvXwRQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288361>

> You have to make sure the fields are set within a global git
> configuration. Did you set this within a previous clone using "git
> config"? If so you need to make sure you use "--global" option to
> write it to your user configuration file so that it is persistent
> across multiple repositories.

Yes, the settings are in my global config.

On Sun, Mar 6, 2016 at 12:18 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sat, Mar 5, 2016 at 5:44 PM, Ryne Everett <ryneeverett@gmail.com> wrote:
>> I'm assuming fsck configurations are supposed to apply to clones but
>> I'm having no luck:
>>
>>     $ git --version
>>     git version 2.7.2
>>     $ git config --get transfer.fsckobjects
>>     true
>>     $ git config --get fsck.badTimezone
>>     ignore
>>     $ cat $(git config --get fsck.skiplist)
>>     5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8
>>     $ git clone https://github.com/kennethreitz/requests.git
>>     Cloning into 'requests'...
>>     remote: Counting objects: 16904, done.
>>     error: object 5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8:
>> badTimezone: invalid author/committer line - bad time zone
>>     fatal: Error in object
>>     fatal: index-pack failed
>>
>> Am I doing something obviously wrong here?
>
> You have to make sure the fields are set within a global git
> configuration. Did you set this within a previous clone using "git
> config"? If so you need to make sure you use "--global" option to
> write it to your user configuration file so that it is persistent
> across multiple repositories.
>
> Not sure if that is what your problem was or not, it is unclear from
> the information provided.
>
> Thanks,
> Jake
