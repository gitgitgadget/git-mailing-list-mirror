From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Fri, 10 Apr 2009 14:04:30 -0500
Message-ID: <b4087cc50904101204l783acb9lb40b7abfc8573a62@mail.gmail.com>
References: <200903171953.23650.ogoffart@kde.org>
	 <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
	 <200904101417.56422.ogoffart@kde.org>
	 <b4087cc50904100537j64e8fef1u157c717fe4d8207b@mail.gmail.com>
	 <alpine.DEB.1.00.0904102019250.10279@pacific.mpi-cbg.de>
	 <b4087cc50904101150i31f1bbfdre73bec44dac580eb@mail.gmail.com>
	 <fabb9a1e0904101154o6b4759ddk879bcdabcc03add6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 21:06:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsM3T-0005bT-Dp
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 21:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939589AbZDJTEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 15:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933354AbZDJTEd
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 15:04:33 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:60527 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbZDJTEc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 15:04:32 -0400
Received: by qyk16 with SMTP id 16so2459367qyk.33
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sLtxkgpzge1Ep7Hkv+mh4wLZ5JK1Uowbr6UJlsJXCPg=;
        b=te1aHL3lG5hSnB8n6HHKrBREBbeCDdihjxaAdpCD6otTl/s3AUYzLl906j06uczw4y
         +NG1eVlkkAebq/xEXLf3XUF9f7YkRQAl/2L90Vb3zEpAqWTlP8OXeSI7s5ud7iaM0Ps6
         DX08fLc5SxivaGg0tBo+f4+4aJfO7cLpJ6/1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gyFLNmYIYRfUeVNARnHNfz83nrGTK/9H0EsAv2Bhg2Ik8Zzg5flXdzSR3MQM7V12KD
         /1ykC5fxysfdN609VHNfOnw8FaDFyS6iGv6YJFA9yCvRkApWcgz4y1KONMrVqMeIeO5O
         b4O72x3IgMnNWc5qZsVX7tyEU6VR8uFr/wUIE=
Received: by 10.224.29.12 with SMTP id o12mr4345120qac.96.1239390270897; Fri, 
	10 Apr 2009 12:04:30 -0700 (PDT)
In-Reply-To: <fabb9a1e0904101154o6b4759ddk879bcdabcc03add6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116276>

On Fri, Apr 10, 2009 at 13:54, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Fri, Apr 10, 2009 at 20:50, Michael Witten <mfwitten@gmail.com> wrote:
>> Also, I still like the idea of being able to write:
>>
>>    git commit --amend HEAD~5 HEAD^
>>
>> and then have the rebase setup and started for me.
>
> Suggested before and shot down with "how would that work in the light
> of merges?

I guess that depends on what Johannes Schindelin said:
> FWIW I planned to split my rebase-i-p patch series into two parts: the first part adding a few commands, and the second part actually making it possible to rebase interactively _and_ preserving merges.  (So far, if you used -p, you better did not reorder or delete any lines.)

Unfortunately, I've never thought about it, so I don't fully
understand the implications. However, why should someone with a
simpler scenario have to suffer because of someone else's hypothetical
nightmare? ;-D

On a separate note:

To clarify, I was specifying two commits that I want to amend (HEAD~5
and HEAD^). For instance, this specifies 3 commits:

    git commit --amend HEAD~5 HEAD^ HEAD~10

However, I'm sure it would also be useful to allow ranges as well.
Should the dot notation (THIS..THAT) be reappropriated? I ask, because
it doesn't really mean range.
