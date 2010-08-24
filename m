From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: reducing object store size with remote alternates or shallow
 clone?
Date: Tue, 24 Aug 2010 13:15:58 -0500
Message-ID: <2dePxmEZeCbs4IkjGd-Ig2cma8lknd0XEwVdaypeAxtQDY3EZeSEPA@cipher.nrlssc.navy.mil>
References: <14526ED4-F65C-4DF2-ABDD-BF1E76DAC2B0@kernel.crashing.org> <7vhbikx8lu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kumar Gala <galak@kernel.crashing.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 20:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ony2v-0003TI-86
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 20:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175Ab0HXSQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 14:16:24 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33678 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab0HXSQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 14:16:23 -0400
Received: by mail.nrlssc.navy.mil id o7OIFxFM015897; Tue, 24 Aug 2010 13:15:59 -0500
In-Reply-To: <7vhbikx8lu.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 24 Aug 2010 18:15:58.0881 (UTC) FILETIME=[66DA3110:01CB43B8]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154331>

On 08/24/2010 11:45 AM, Junio C Hamano wrote:

> How about doing
> 
>     $ LINUS=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

>     $ git fetch $LINUS
>     $ git bundle create myfork.bundle HEAD..master

I think you mean

      $ git fetch $LINUS master
      $ git bundle create myfork.bundle FETCH_HEAD..master

-Brandon
