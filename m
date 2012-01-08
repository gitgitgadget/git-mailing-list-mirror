From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] revert: decouple sequencer actions from builtin
 commands
Date: Sun, 8 Jan 2012 14:48:15 -0600
Message-ID: <20120108204815.GP1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-3-git-send-email-artagnon@gmail.com>
 <20120108193454.GG1942@burratino>
 <CALkWK0kHn+SDaeRHa8bUHWvOEVkr01sVDzvnw9E+-Nne2cii1Q@mail.gmail.com>
 <20120108200910.GK1942@burratino>
 <CALkWK0=kw=EEXDfnrFkeNV678r4u3v72-=hKh9w8ujRN125NPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:43:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjzaE-0000ig-Fz
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab2AHUnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 15:43:09 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46642 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab2AHUnI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 15:43:08 -0500
Received: by ggdk6 with SMTP id k6so1327008ggd.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hgi9XZuK2QkV9Q/wGyXN6O9OaNiD//uqt243IPTy+IY=;
        b=Xzdl6sDplmojktt7D154SVByN6LQ0JpuXK40XoU8rgcuWXN1TmY1in1DP3fK4vRvoc
         UyDk0nEWlvj75QC5Zc4f69w4OyV0FjhUUhESUD/V/Da6zR/YNxgAOTiX9CL6hOfcpC7Z
         xxE0EjO7jBt4RB1wG2xZIwT+CJPqc+DxTy6QI=
Received: by 10.101.210.30 with SMTP id m30mr5573402anq.64.1326055387866;
        Sun, 08 Jan 2012 12:43:07 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o50sm99051048yhl.9.2012.01.08.12.43.06
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 12:43:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=kw=EEXDfnrFkeNV678r4u3v72-=hKh9w8ujRN125NPQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188133>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:
>> Ramkumar Ramachandra wrote:
>>> Jonathan Nieder wrote:

>>>> So what change does the patch actually make? =C2=A0Is this a renam=
ing?
>>>
>>> Yes, it renames "action" to "command" where appropriate.
>>
>> Wouldn't a simple renaming have a diffstat with the same number of a=
dded
>> and removed lines?
>
> Yes, almost.  A few extra lines added because I needed a new data enu=
m
> for the "command"; also added a convenience function: action_name().

It's not a simple renaming, then.

What user-visible effect will this have, if any?  What programmer-visib=
le
effect will it have, if any?  I _really_ should not have to read the pa=
tch
to learn the impact of a patch.
