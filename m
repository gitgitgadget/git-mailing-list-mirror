From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] avoid possible overflow in delta size filtering computation
Date: Tue, 24 Mar 2009 15:20:08 -0500
Message-ID: <IJd5MMCs9G_oJF_jS9hZAHkoKM0IvDNHuvHhhQ3MnKbPbSQlMYjOAg@cipher.nrlssc.navy.mil>
References: <alpine.LFD.2.00.0903241535010.26337@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 21:22:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmD8Z-0008GG-ER
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 21:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763810AbZCXUUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 16:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763036AbZCXUUd
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 16:20:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58276 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763292AbZCXUUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 16:20:32 -0400
Received: by mail.nrlssc.navy.mil id n2OKK8jV007629; Tue, 24 Mar 2009 15:20:08 -0500
In-Reply-To: <alpine.LFD.2.00.0903241535010.26337@xanadu.home>
X-OriginalArrivalTime: 24 Mar 2009 20:20:08.0115 (UTC) FILETIME=[ECF69830:01C9ACBD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114486>

Nicolas Pitre wrote:
> On a 32-bit system, the maximum possible size for an object is less than 
> 4GB, while 64-bit systems may cope with larger objects.  Due to this 
> limitation, variables holding object sizes are using an unsigned long 
> type (32 bits on 32-bit systems, or 64 bits on 64-bit systems).

FYI: except on windows 64-bit where long is still 32 bits AFAIK

-brandon
