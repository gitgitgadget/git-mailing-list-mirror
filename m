From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 00/23] http*: refactor (v6)
Date: Wed, 10 Jun 2009 18:36:23 +0800
Message-ID: <be6fef0d0906100336g44b75800w42cb5cd9ee33f594@mail.gmail.com>
References: <20090606164253.65a945ba.rctay89@gmail.com>
	 <7v8wk5dyrw.fsf@alter.siamese.dyndns.org>
	 <be6fef0d0906061741p6f3864a9m25d25e23ef0db760@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 12:37:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MELBG-0005eg-Bm
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 12:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758313AbZFJKgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 06:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757149AbZFJKgW
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 06:36:22 -0400
Received: from mail-px0-f200.google.com ([209.85.216.200]:56753 "EHLO
	mail-px0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbZFJKgV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 06:36:21 -0400
Received: by pxi38 with SMTP id 38so605896pxi.33
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vJnTweLw0JY4jAH8Rlzsh2UlZ+EKzlUXF/8rcdNjceQ=;
        b=rc/X7+jYkBBpvOZ/GwrRapVBAsA3tNOuMb5dLkRsvJQLYbllrRdA8CbsS0W7tpZN8V
         QJDkigf9NCKtOMKreHXuCvp46rCkMQcPVfA6wg5AWZ48eA1B/6wsNohIWM0YikRxEBS1
         TL8UfiHH2WT1rpYKwYoS+iU6/xkO14OZ0ZLd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ifRS8R9wEC1s3Cytmx2ayeAIunmOZAqq+vLJ8IjoTLCvBn2XH3RwwVY2DU67D8hhLN
         qSsKHNLyYsq3GIUHEhqsLU+oSHZHq/bKhv6E374QxjLS73Mz84+YbpgUPFRevQ/pJANu
         8bw0c8n6Eso4yRV11QOvpP8vdSte/mPzgUtQU=
Received: by 10.142.211.7 with SMTP id j7mr462836wfg.28.1244630183555; Wed, 10 
	Jun 2009 03:36:23 -0700 (PDT)
In-Reply-To: <be6fef0d0906061741p6f3864a9m25d25e23ef0db760@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121269>

Hi,

On Sun, Jun 7, 2009 at 8:41 AM, Tay Ray Chuan<rctay89@gmail.com> wrote:
> On Sun, Jun 7, 2009 at 2:04 AM, Junio C Hamano<gitster@pobox.com> wrote:
>> Thanks, will queue, but please double check the result after I push it
>> out, as I found some other changes not listed above, relative to what was
>> queued in 'pu' (I am not complaining; I am asking your extra set of
>> eyeballs in case I somehow screwed up applying your series to my tree).

Looks ok; sorry for the trouble caused.

-- 
Cheers,
Ray Chuan
