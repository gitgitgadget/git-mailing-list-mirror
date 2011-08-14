From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [feature wishlist] add commit subcommand to git add -i
Date: Sun, 14 Aug 2011 01:48:49 -0700
Message-ID: <CAOTq_pvMv6JN_jpQvDsmQTwmMgQK9JzuwXr+VF1T6X4=qf3GsQ@mail.gmail.com>
References: <CAJfuBxwW8Dyp8FTS13uPOBKZGL9JOEqaSOhGN+zBJ_8BHpJE3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 10:49:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWNf-0006Oq-7v
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab1HNItL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 04:49:11 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:57643 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab1HNItJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 04:49:09 -0400
Received: by yie30 with SMTP id 30so2763415yie.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mLxNNzPx7HUu48SM54nAjeoH11eT9oLlR28LB2QZ/DM=;
        b=kmnJvnZHk669kqS0mc+C3ORnNv6qKa9hwHm0FpKqOCaWgOoRgeuGdCiUC/P0N8oqBT
         aApPmTzivWXOz0eqaSk8+w27bFG9yyHN4tV4EtR2cccyHFFOxLrm3nRuAZG8mAdeI0C2
         zi+aDBts+UnCSHJFFuVAwcIQ8B21js72bvO64=
Received: by 10.236.115.73 with SMTP id d49mr8807266yhh.245.1313311749053;
 Sun, 14 Aug 2011 01:49:09 -0700 (PDT)
Received: by 10.236.109.167 with HTTP; Sun, 14 Aug 2011 01:48:49 -0700 (PDT)
In-Reply-To: <CAJfuBxwW8Dyp8FTS13uPOBKZGL9JOEqaSOhGN+zBJ_8BHpJE3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179314>

On Sun, Aug 14, 2011 at 1:38 AM, Jim Cromie <jim.cromie@gmail.com> wrot=
e:
> going further, if git rebase -i =A0had ability to =A0"back" a fixup p=
atch
> back to where it should have been, and adjust the intervening patches
> where conflict would normally happen, that would be awesome.
> Simplistically, this would just shift the patch 1 step back iterative=
ly,
> until it wouldnt apply properly, and then --abort, stopping at the la=
st
> clean rebase.
>
> apologies if this is too hair-brained, or already done.

It sounds like you're looking for several git commit
(-p|--interactive) --fixup <commit>, followed by a git rebase -i
--autosquash. It's not quite as automatic as you describe, but I think
that automating it would be pretty hard to do correctly.

Conrad
