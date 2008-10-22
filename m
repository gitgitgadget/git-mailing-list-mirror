From: Diego Algorta <diego@oboxodo.com>
Subject: Older git version on the server
Date: Wed, 22 Oct 2008 18:33:01 -0200
Organization: www.oboxodo.com
Message-ID: <48FF8DFD.2060700@oboxodo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 22:34:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskPa-0000pT-2U
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbYJVUdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754498AbYJVUdU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:33:20 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:52994 "EHLO
	spaceymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754383AbYJVUdU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2008 16:33:20 -0400
Received: from [192.168.1.1] (r190-64-164-121.dialup.adsl.anteldata.net.uy [190.64.164.121])
	by spaceymail-a7.g.dreamhost.com (Postfix) with ESMTP id 2776214252
	for <git@vger.kernel.org>; Wed, 22 Oct 2008 13:33:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98905>

Hi all,

= Background
We are a team of 3 developers. Each one has his own clone from a central 
public repo in our server where we all push and pull from (you can tell 
we come from svn). We do deployments on production from that repo's 
master branch.

= Problem
We recently started using git submodules and now we're facing a problem 
when switching between branches (git checkout) which have the same 
submodule but linked from different sources. Some google research says 
the new "git submodule sync" feature may be the solution, but we can't 
use a version newer than 1.5.6.1 on the server.

= Question
Would it be a problem for us to use 1.6.0.3 on our development 
environments and keep using 1.5.6.1 on the server to do the deployments?

Thank you!
-- 
Diego Algorta - Web Developer & SysAdmin -
http://www.oboxodo.com - http://diego.algorta.net
