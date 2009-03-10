From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: BUG: git can't handle certain kinds of renames in merges
Date: Tue, 10 Mar 2009 15:51:00 -0400
Message-ID: <81bfc67a0903101251r29e14154ud289646a1f5c20e0@mail.gmail.com>
References: <81bfc67a0903100745m3a425337h3f4f7cdbde6b5cfe@mail.gmail.com>
	 <252A6411-2658-4DC6-A7F4-29CA3981F8FB@frim.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pieter de Bie <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Tue Mar 10 20:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh80N-00015S-Cd
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 20:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbZCJTvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 15:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754536AbZCJTvK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 15:51:10 -0400
Received: from mail-qy0-f122.google.com ([209.85.221.122]:49936 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbZCJTvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 15:51:07 -0400
Received: by qyk28 with SMTP id 28so1912470qyk.33
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=po4TRkMZvWthenuy0gM5cKLYjMMU1urpg4dyitIbJJI=;
        b=gxEizW7/LsvBniWEGcm3mcth9zSJEoWEptUX5ZH33nma+ps+DOUb1NhQLFaKuec31D
         FM/8N0hhRKrvmksK0PP3KGuSxfkRaOSj7H6SH+ahNa1gZxL2f2hyEwmTE4k1fzTtMFru
         vK/SN9lNMJ+Dbk0GAm/KLKMlX/6Kt1jFzUVdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UutF6WBK4Drv/Z7BEJ/T7CUTyn7lyx5KhVg2nDxjnfKw9ujwUXPpXMP+FdArHcwGgA
         fcX8IKooAVCrscPoQHCX1Z7ccF38ml+amSnOrqpwlF/1EDi5YI/vSumQZrWf3gi1hLIr
         jNgSz64Fjvj7yO3XM7Jbpug0DvnCOA6hvg8PM=
Received: by 10.229.73.193 with SMTP id r1mr4479958qcj.53.1236714660411; Tue, 
	10 Mar 2009 12:51:00 -0700 (PDT)
In-Reply-To: <252A6411-2658-4DC6-A7F4-29CA3981F8FB@frim.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112843>

On Tue, Mar 10, 2009 at 12:02 PM, Pieter de Bie <pieter@frim.nl> wrote:
> ind of toy examples. Git can't infer the file
> was renamed because almost nothing is similar enough. Take
> a look at the attached script and run it with 'sh test.sh'
> and 'sh test.sh real_test', and look at the difference.

I've got a much bigger example(hundreds of lines, and dozens change at
a time)  which resolves in the same problem or worse with
git-tree-write errors. I'm trying to figure out now how to work around
this issue.

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
