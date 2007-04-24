From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Mon, 23 Apr 2007 17:46:40 -0700
Message-ID: <462D5370.8040905@zytor.com>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com> <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com> <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com> <alpine.LFD.0.98.0704220925420.28339@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 02:47:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg9C3-0008DM-MI
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 02:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030996AbXDXArl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 20:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031000AbXDXArl
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 20:47:41 -0400
Received: from terminus.zytor.com ([192.83.249.54]:42493 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030996AbXDXArk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 20:47:40 -0400
Received: from [172.27.0.16] (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l3O0keRb017268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2007 17:46:41 -0700
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <alpine.LFD.0.98.0704220925420.28339@xanadu.home>
X-Virus-Scanned: ClamAV 0.88.7/3152/Mon Apr 23 15:34:59 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=2.0 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no
	version=3.1.8
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45394>

Nicolas Pitre wrote:
> 
> Object names aren't 40 bytes.  They are 20 bytes.
> It  is their hex representation that takes 40 bytes.
> 

Sure, but that's the way they're stored in *most* git objects, in 
particular in commit objects.

	-hpa
