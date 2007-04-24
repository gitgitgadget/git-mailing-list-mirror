From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bug with gitweb on kernel.org
Date: Mon, 23 Apr 2007 17:44:35 -0700
Message-ID: <462D52F3.5050508@zytor.com>
References: <alpine.LFD.0.98.0704192255180.4504@xanadu.home>	 <1177286943.24896.14.camel@localhost.localdomain>	 <alpine.LFD.0.98.0704222112040.28339@xanadu.home> <1177294925.24896.48.camel@localhost.localdomain> <462D4CEC.6010204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog19@eaglescrag.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 02:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg9A2-0007NS-Ja
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 02:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030881AbXDXApf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 20:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030996AbXDXApf
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 20:45:35 -0400
Received: from terminus.zytor.com ([192.83.249.54]:47779 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030881AbXDXApe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 20:45:34 -0400
Received: from [172.27.0.16] (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l3O0iZ9a017129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2007 17:44:36 -0700
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <462D4CEC.6010204@zytor.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45393>

H. Peter Anvin wrote:
> 
> Presumably the motivation is so you know ahead of time that you can 
> invoke an XML parser rather than an SGML/HTML parser.
> 
> Note: http://www.w3.org/TR/xhtml-media-types/ states that text/html is 
> considered acceptable for HTML-compatible XHTML 1.0 but no other version 
> of XHTML 1.0.  One of the main issues with making XHTML 1.0-compatible 
> is to make sure there is a space before the final / in the last 
> singleton: <foo /> rather than <foo/>
> 

This might also be useful reading:

http://www.mozilla.org/docs/web-developer/faq.html#xhtmldiff

	-hpa
