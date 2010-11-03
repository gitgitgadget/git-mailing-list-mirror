From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: handle symlink replaced by file
Date: Wed, 3 Nov 2010 21:07:11 +0100
Message-ID: <AANLkTi=P+sKzYSkeS2-N+DerP3zdRgrDnuNuXbK0O89s@mail.gmail.com>
References: <AANLkTi=dA+mj1KDpAgGAtg1S5Gt5wXAJ4zLd-tLob=DH@mail.gmail.com>
	<8739rqqb4m.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Nov 03 21:07:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDjc6-00013b-VP
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 21:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab0KCUHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 16:07:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63011 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab0KCUHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 16:07:12 -0400
Received: by ywc21 with SMTP id 21so800753ywc.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=XACaRf1vMQpApyMpY1vP8/KKMyamGKcY/JkGjOvgVew=;
        b=IROcz+0BWISKVC0mL+7LxPmUcbeIUcd3u7k4BvAnWUnnddL5W+6WCrLBOud154Sd6R
         No9K/+CGfyMDYjPIROw+3aRTHnKK/tSjzT2oW8fDeWPClfYr+2MIuyxrmmBj1bIAG3oH
         1N7Bp0RuPTp0vlt0LSJ3qrlxQzb2L3ZOfC9RA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=flNehr9OSVUkSGdrdArhWhJpxGwbV7D++dCLNCGEL6t7I9XhdWP2IWIt3A76sAvyaF
         H21y38PS5F9MM2VTKoeAYYWmLQi8S3qVyu3glMQb+/g/ScWFs8leNA22dn/Q5d1CgNSJ
         cIHPW/BUFZV2UU1vBatOj5xOTFjydENjD4jSk=
Received: by 10.42.210.143 with SMTP id gk15mr13444544icb.509.1288814831455;
 Wed, 03 Nov 2010 13:07:11 -0700 (PDT)
Received: by 10.42.114.15 with HTTP; Wed, 3 Nov 2010 13:07:11 -0700 (PDT)
In-Reply-To: <8739rqqb4m.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160637>

On Thu, Oct 28, 2010 at 14:27, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> This patch just handles the second segment without generating the error
> really. It doesn't attempt to do any pretty output.

Thanks for the patch. I haven't test it yet. Actually I can't find
documentation, that git outputs two diffs when the path changes the
type. And I have no idea how to present this in git gui.

Bert
