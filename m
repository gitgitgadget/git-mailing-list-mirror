From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-gui disagrees with git status
Date: Tue, 11 May 2010 09:27:49 -0500
Message-ID: <20100511142749.GA12896@progeny.tock>
References: <y2m3b1db1e51005101432je9e75a53vbb3781fa33aa83e7@mail.gmail.com>
 <20100510213926.GA7156@spearce.org>
 <buo632vj8px.fsf@dhlpc061.dev.necel.com>
 <4BE8F1DB.2060205@viscovery.net>
 <20100511062728.GA29654@progeny.tock>
 <AANLkTimcB8Ozqhti66cYzNMkIcIDIxChCj_8GDrhC4ep@mail.gmail.com>
 <20100511140458.GA3132@progeny.tock>
 <AANLkTilDmQBIq2xJCx_t5Qt15xXFK_3JRoiI6Y_Y8F-2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Bill Winspur <bwinspur@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 16:27:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBqR6-0007AM-1D
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 16:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758230Ab0EKO1r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 10:27:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58011 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148Ab0EKO1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 10:27:46 -0400
Received: by fxm19 with SMTP id 19so485748fxm.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6aHhk6m5FL6ewAFM9KuCTj5iuqNHpzFVoZgti8dHVt0=;
        b=HvPvrwT4fupnPyW/88L/5A6XQy4ay5PLBZiVP5QS/O3LGD7GCAkzhS5QhCcU9ZdVGL
         /8IsE/As/5BOshBR17OkCcWqH1R9mkXO5BH5EV/jkjN8OjrdmiUMPny1d0DuT8cGbCLM
         Oq9oEsnTpyT9MLKfNXT4wMqJVejc4dm6IFeRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=X3XcUNygHvPKmxOdsjRo7SKoegXbjjXIz3GRihVaANsmEI0SD8SvyKvDyC7Ib/y/gj
         NY3/SEnKn/r4LiNEUthOKKqMHWCV2y8iGOvGIwEO3FAZVOX3lasa+fzMGRDDI3Q3MEio
         CIPL2JY5IO9KyBaPqQIpYg4Czfy30myqmLI8s=
Received: by 10.223.16.207 with SMTP id p15mr6308924faa.99.1273588064227;
        Tue, 11 May 2010 07:27:44 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u12sm26871634fah.4.2010.05.11.07.27.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 07:27:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilDmQBIq2xJCx_t5Qt15xXFK_3JRoiI6Y_Y8F-2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146896>

[repopulating cc list]

Bill Winspur wrote:
> On Tue, May 11, 2010 at 8:04 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> Bill Winspur wrote:

>>> And, to avoid reverting to the command line, implement a GUI add of
>>> the currently
>>> selected untracked file to move untracked to tracked && staged.
>>
>> Doesn=E2=80=99t double-clicking do that?
[...]
> Replying to all:
> And, to avoid reverting to the command line, implement a GUI add of
> the currently selected untracked file to move untracked to tracked &&=
 staged.

Sorry for the lack of clarity.  Adding CCs again, though I am still not
sure I understand what you are asking for.  Maybe you were hoping for a
button rather than having to click the file icons.  Whatever it was, I
encourage you to play around with git-gui/git-gui.sh, after the
create_common_diff_popup {} function.

Jonathan
