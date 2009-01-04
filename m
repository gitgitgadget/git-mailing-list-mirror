From: "Arnaud Lacombe" <lacombar@gmail.com>
Subject: Re: git-branch --print-current
Date: Sun, 4 Jan 2009 12:55:44 -0500
Message-ID: <1a69a9d80901040955v51671b1dv6ca6fc644455b6b1@mail.gmail.com>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	 <1a69a9d80901040021i1dae2c6j7337cf57eed6476a@mail.gmail.com>
	 <quack.20090104T0440.lthbpun1bxo@roar.cs.berkeley.edu>
	 <9b18b3110901040449x65c63d6fo3d9fec9ddd5670c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Karl Chen" <quarl@cs.berkeley.edu>,
	"Git mailing list" <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 18:57:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJXDp-0005Yq-Fk
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 18:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbZADRzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 12:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbZADRzr
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 12:55:47 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:3478 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbZADRzq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 12:55:46 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2208234ywe.1
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yhKI5d3/Xkn6RB9A6syUfJT0ca0ufRZb3kVLNHtA280=;
        b=Uv7VBb9udZtP2a7t/ANMdo7cje8gdJ9PkdwIY9leqSWweTgqacL1A/3R3Lqj2ZUOJ4
         CoUcQ8ytOTDAJvT7LRV5CLWHSZvj+MdCg7fYz6EzkxLyGtyNVEfUj8yCue4C1JrQiG8G
         UnzVV3TSSn/YzDUbUM3gQKpfoHlJvfniz7BGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=umXSR5dcvsmtCUBSsifCoEFe1Y7VI2jypdEKAyaRmmJtOUq/thqtV2bCeYww+lHRoh
         nIP01ME1npFiqKHWwYjX3TdREPpHYGjgQ4u8kcXrh4/2S59XQtz9oZHM9ZYUQCeS5Q+x
         M6IbcogdPF5OKyhbC2/gOD4DuExVeFFiQY02Q=
Received: by 10.151.109.11 with SMTP id l11mr37521737ybm.32.1231091744441;
        Sun, 04 Jan 2009 09:55:44 -0800 (PST)
Received: by 10.151.48.18 with HTTP; Sun, 4 Jan 2009 09:55:44 -0800 (PST)
In-Reply-To: <9b18b3110901040449x65c63d6fo3d9fec9ddd5670c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104529>

Hi,

On Sun, Jan 4, 2009 at 7:49 AM, demerphq <demerphq@gmail.com> wrote:
> 2009/1/4 Karl Chen <quarl@cs.berkeley.edu>:
>> On 2009-01-04 00:21 PST, Arnaud Lacombe writes:
>>    Arnaud> $ git branch | awk '/^\*/ {print $2}'
>>
>> Yet another addition to the list of ways to pipeline it, this one
>> probably the shortest :)
>
> Unfortunately it doesnt work well when you arent on a branch:
>
>  $ git branch | awk '/^\*/ {print $2}'
>  (no
>
> So far two apparently expert git people have given solutions to this
> problem that don't elegantly handle the edge cases.
>
my bad:
$ git branch | awk '/^\*/ {print substr($0, 3)}'

 - Arnaud
