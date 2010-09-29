From: yj2133011 <274040551@qq.com>
Subject: Re: [PATCH 1/6] Add struct pathspec
Date: Tue, 28 Sep 2010 23:11:18 -0700 (PDT)
Message-ID: <1285740678928-5582619.post@n2.nabble.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com> <1284938514-16663-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 08:11:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0psz-0007np-Mx
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 08:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab0I2GLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 02:11:19 -0400
Received: from kuber.nabble.com ([216.139.236.158]:41306 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab0I2GLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 02:11:19 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <274040551@qq.com>)
	id 1P0pss-0008Sw-U8
	for git@vger.kernel.org; Tue, 28 Sep 2010 23:11:18 -0700
In-Reply-To: <1284938514-16663-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157532>


This struct for now is just a wrapper for the current pathspec form:
const char **. It is intended to be extended with more useful
pathspec-related information over time.

The data structure for passing pathspec around remains const char **,
struct pathspec will be initialized locally to be used and destroyed.
Hopefully all pathspec related code will be gradually migrated to pass
this struct instead.


-----
The voice input and output is very good in this 
http://www.tomtop.com/black-ps3-wireless-bluetooth-headset-for-playstation-3.html?aid=z
Wireless PS3 Headset . It is compatible with all PS3 games.Buy from Reliable 
http://www.tomtop.com/google-android-7-notebook-3g-tablet-pc-umpc-wifi-mid-pda.html?aid=z
Google Android PC  apad Wholesalers.
-- 
View this message in context: http://git.661346.n2.nabble.com/PATCH-0-6-Introduce-pathspec-struct-tp5548679p5582619.html
Sent from the git mailing list archive at Nabble.com.
