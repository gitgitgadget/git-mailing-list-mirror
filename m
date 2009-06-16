From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: compiling git on debian
Date: Tue, 16 Jun 2009 13:12:31 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.0906161309370.14053@yvahk2.pbagnpgbe.fr>
References: <f46c52560906160406t910f5f3v4040525531ad78c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 13:10:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGWYk-0000Bb-0l
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 13:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbZFPLK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 07:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZFPLKZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 07:10:25 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:35968 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbZFPLKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 07:10:25 -0400
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n5GBAL3R028016;
	Tue, 16 Jun 2009 13:10:21 +0200
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <f46c52560906160406t910f5f3v4040525531ad78c4@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121672>

On Tue, 16 Jun 2009, Rustom Mody wrote:

> Im trying to compile git on debian etch and get a problem with curl-config 
> not found. I gather curl-config is in a number of debian dev packages.

> Can someone tell me which which package?

$ dpkg -S /usr/bin/curl-config
libcurl4-openssl-dev: /usr/bin/curl-config

(or you can opt to get the gnutls version if you prefer that)

-- 

  / daniel.haxx.se
