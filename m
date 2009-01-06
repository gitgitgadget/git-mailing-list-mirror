From: "=?ISO-8859-1?Q?=D8yvind_Harboe?=" <oyvind.harboe@zylin.com>
Subject: Re: Migration problems from SVN
Date: Tue, 6 Jan 2009 13:44:02 +0100
Message-ID: <c09652430901060444w2aff527fmb0855aaa707f84fa@mail.gmail.com>
References: <c09652430901060409p23d2737ck6e41b3f8f1eaf01@mail.gmail.com>
	 <200901061339.49843.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 06 13:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKBQB-0008VA-Hy
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 13:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbZAFMvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jan 2009 07:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbZAFMvK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 07:51:10 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:62696 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbZAFMvJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 07:51:09 -0500
Received: by bwz14 with SMTP id 14so23952870bwz.13
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 04:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=IUX/Hy05boSBhEHZRlzs4IBWNS87plP36MUnHncQxzQ=;
        b=DOtYVLQbIqPi9uYTgxns4XdaihS58AWs5gfnoe/wYQqNYIMJCWfkYe9LnBhgrQn0Be
         laT0kGucSCQhwzosD5zBWsZCC5RtjnizMi386Tsc0WKQ+59QYP1mZTcaw21XNYmxeUmG
         es/FMsSinyJHXEXVITwiElBh/eueOclXQtmNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=SlabyrSHj9Uf2KKTx/ghxAPoTugEphUm760LLIljZwrtyXHsKb3ieMKoAncX4MHuLD
         Y3twTyYoWsCfjjNZQpVh/2LcCffwIJvFDPZODOntzEgua5AKKjFRK5IBOpaL/J2uXUV4
         ADfY/YMQGUTYnevV6opybYsPSFczYgTWQHBG8=
Received: by 10.223.106.73 with SMTP id w9mr15426137fao.21.1231245842586;
        Tue, 06 Jan 2009 04:44:02 -0800 (PST)
Received: by 10.223.121.142 with HTTP; Tue, 6 Jan 2009 04:44:02 -0800 (PST)
In-Reply-To: <200901061339.49843.trast@student.ethz.ch>
Content-Disposition: inline
X-Google-Sender-Auth: 390826af436ae66d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104683>

On Tue, Jan 6, 2009 at 1:39 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> =D8yvind Harboe wrote:
>> If I early on and accidentally commit a *large* binary object, how d=
o I get rid
>> of it from .git again?
>
> git-filter-branch can do that.  See the top of the EXAMPLES section i=
n

Ah! Thanks! I will study this. Thanks for your patience with a beginner=
, I guess
I should have spotted this one. There is a lot to read and git is refre=
shingly
different and there is a lot of things to catch up on.




--=20
=D8yvind Harboe
http://www.zylin.com/zy1000.html
ARM7 ARM9 XScale Cortex
JTAG debugger and flash programmer
