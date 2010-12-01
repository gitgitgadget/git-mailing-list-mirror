From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] GIT connect "connect to host HOSTNAME port 22: Bad file
 number" message shown
Date: Wed, 1 Dec 2010 15:19:35 +0100
Message-ID: <AANLkTi=b6-AE-gyS2L_RjEsUEBj1CyMXXtFB8Echt9j_@mail.gmail.com>
References: <AANLkTi=GnOJvZE1hGcCbRq9G8KrqnM2ULXZXRCAP-Gpv@mail.gmail.com>
 <AANLkTi=tm9wX08_o2xgmSS371atgsfPqydT-AZLYxNwJ@mail.gmail.com> <AANLkTimCgHwXfYJveFFKK3JEa6j3rieeQMzxxHzFVZ9f@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: GAURAV BAHL <engg.bahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 15:20:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNnXP-00025T-Pr
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 15:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab0LAOT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 09:19:57 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61992 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558Ab0LAOT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 09:19:57 -0500
Received: by fxm20 with SMTP id 20so97282fxm.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 06:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=swB6bBkiheYp99g9Fv+zYlL9WGLEG0XrX/nw1Y/rDDY=;
        b=FRPm6wvGOIHZyIDnW3oYfwcL8ah0HW4Zv9P5WghtsJcsfD20BueHAtjNRshh2esX4E
         24O4MqnIKQtWYpdAYS3v8vdU2hXvusT2JuC4byCvWgoPqfG/FjLxIRXffTQuO7kayoVf
         KZF7ow5nNEu4xCNMP0oaIpYWnj2lcY4V93vr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=JCiI8oGuqg11zS+gLrgMYKFp1XQIgOtyrBwZm+8s5GHHr124D98Hg5FdPuNdaqA8S9
         9xtTKeQYczdiX29W35P1s06JUrkB8jGuSC0TTx9V0z0XPiyCyGQJLdWNP97xJ1Ip4Oye
         zlloxXEFbQFzEXhyMeN5pFaTl6HjF3SFtW8vk=
Received: by 10.223.107.16 with SMTP id z16mr8387156fao.7.1291213195619; Wed,
 01 Dec 2010 06:19:55 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Wed, 1 Dec 2010 06:19:35 -0800 (PST)
In-Reply-To: <AANLkTimCgHwXfYJveFFKK3JEa6j3rieeQMzxxHzFVZ9f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162519>

First of all, we don't top-post on these mailing lists, as it makes
the conversation harder to read for other people.

Secondly, don't cull the CC list (hit "reply to all" in GMail) in the
future, so other people is able to read your response.

I've fixed these problems this time, so others might jump in.

On Wed, Dec 1, 2010 at 3:00 PM, GAURAV BAHL <engg.bahl@gmail.com> wrote:
> On Wed, Dec 1, 2010 at 8:33 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>
>> On Wed, Dec 1, 2010 at 1:48 PM, GAURAV BAHL <engg.bahl@gmail.com> wrote:
>> >
>> > My Manager asked me sent it out c/Documents and Settings
>> > Administrator/.ssh/id_rsa.pub file to someone for adding so that git
>> > should
>> > be available to me.
>> > Once done with the approval , I tried with above command and faced Bad
>> > file
>> > name issue
>> >
>> > Let me know for more Infn.
>> >
>> > After addition of the key the GIT bash Testing connection using (ssh
>> > git@HOSTNAME info) command outputs as
>> >
>> > gaurav.bahl@008_GAURAVB ~
>> > $ ssh git@HOSTNAME info
>> > ssh: connect to host HOSTNAME port 22: Bad file number
>> >
>>
>> You probably need to replace "HOSTNAME" with the host name of the
>> server you want to test the connection against.
>
> Thats' what I have done - Security point of view I haven't stated HOSTNAME
> in the inline message
>

OK, then I 'm out of suggestions for now.
