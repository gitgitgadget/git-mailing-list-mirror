From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv12 00/23] git notes
Date: Wed, 27 Jan 2010 21:18:27 +0100
Message-ID: <fabb9a1e1001271218g30231896q77766c23def5656d@mail.gmail.com>
References: <1264593120-4428-1-git-send-email-johan@herland.net> 
	<7vzl3zpbbz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 21:20:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaELs-0004Ju-4d
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 21:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab0A0USs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 15:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027Ab0A0USs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 15:18:48 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:53148 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab0A0USr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 15:18:47 -0500
Received: by pxi12 with SMTP id 12so4679512pxi.33
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 12:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Do1MAuxRNLNwXQcYuLk2VJNKVVv9IJjT1+fCKPGXn5w=;
        b=TsKOzk8arxxfm4FNYGYZFA/wLGqIqFNRM0l/r0o3ZXOcnvD4Luj+n+9VJKdEiLHDsL
         qys6+YAgccd77wN7r+xvjheR5QAGGGTpgL2/VHrZAsHzU5Yr1oWphEntVCgyOFQfdkn+
         zxbD6FQRE0PY9WV6i4cSDtfyAnli0nRRKLe5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sIKuMu0K00zY0zlqxMDtQt0YWrCFG3y6f+tsH1R/yuG2JtbKuUFd0DwBE6g0+41Oen
         b1YIRm6Zg3VfbjVQ753Vyw4k2zUEMCBQQW7XIvFTOMVnSbZCBDRLsTG+zNV65fTosTCm
         yWByvyuGw4oN0Fq8TfZHTrQOo8iV/X3AXLaH4=
Received: by 10.142.61.23 with SMTP id j23mr560676wfa.322.1264623527161; Wed, 
	27 Jan 2010 12:18:47 -0800 (PST)
In-Reply-To: <7vzl3zpbbz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138193>

Heya,

On Wed, Jan 27, 2010 at 21:00, Junio C Hamano <gitster@pobox.com> wrote:
> I would expect "git notes edit" to be "edit starting from the existing one
> (if exists)", and "git notes add" to be "add notes to a commit that lacks
> one, complain if it already has notes, and allow --force to replace".

Agreed, that makes a lot of sense; I had similar thoughts (at least,
on that the current design was flawed), and I think what you propose
is a sane interface.

-- 
Cheers,

Sverre Rabbelier
