From: Vitali <vit.der.kapa@gmx.com>
Subject: blame formatting bug
Date: Thu, 09 Dec 2010 11:11:38 +0300
Message-ID: <4D008F3A.7080205@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 09:11:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQbbK-00045h-Qh
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 09:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856Ab0LIILi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 03:11:38 -0500
Received: from mailout-eu.gmx.com ([213.165.64.42]:44823 "HELO
	mailout-eu.gmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752403Ab0LIILh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 03:11:37 -0500
Received: (qmail invoked by alias); 09 Dec 2010 08:11:35 -0000
Received: from unknown (EHLO [46.147.15.77]) [46.147.15.77]
  by mail.gmx.com (mp-eu004) with SMTP; 09 Dec 2010 09:11:35 +0100
X-Authenticated: #66357070
X-Provags-ID: V01U2FsdGVkX19wL5gGws1w737XAUSmLXr3yxHJ9+WthVGtQN7jiD
	PsvQX6KRD9mJch
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163273>

Hi.

On the jquery repo the following command:

git blame df9c37ec852f8c873e226cd0ae190f969e0edc17 -- jquery/jquery.js > 
blame

gives me the file with this:

c3c706d3 jquery/jquery.js (John Resig 2006-06-22 05:23:38 +0000  576) 	},
6ae392a4 jquery/jquery.js (John Resig 2006-06-22 20:14:41 +0000  577) 	
df9c37ec jquery/jquery.js (John Resig 2006-07-09 20:49:40 +0000  578) 
extend: function(obj,prop) {
		if ( !prop ) {
			prop = obj;
			obj = this;
		}
	
		for ( var i in prop )
			obj[i] = prop[i];
	
		return obj;
	}
c3c706d3 jquery/jquery.js (John Resig 2006-06-22 05:23:38 +0000  579) };
^8a4a1ed core/core.js     (John Resig 2006-03-22 03:33:07 +0000  580)
df9c37ec jquery/jquery.js (John Resig 2006-07-09 20:49:40 +0000  581) 
jQuery.extend = jQuery.fn.extend;

Looks like bug.
