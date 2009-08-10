From: Mark A Rada <marada@uwaterloo.ca>
Subject: Instaweb using ModPerl::Registry over ModPerl::RegistryBB
Date: Sun, 9 Aug 2009 21:51:56 -0400
Message-ID: <BC9876EF-222F-4023-B5FE-5C30A0D3C683@mailservices.uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 03:52:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaK3n-0006k8-88
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 03:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbZHJBwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 21:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbZHJBwG
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 21:52:06 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:34555 "EHLO
	psyche.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754545AbZHJBwF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 21:52:05 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by psyche.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7A1puA0010868
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sun, 9 Aug 2009 21:52:03 -0400
X-Mailer: Apple Mail (2.936)
X-UUID: 28e34d9b-e7e9-4079-bc66-9d5008b75e4a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125397>

Hi,

I've noticed that the instaweb script uses ModPerl::Registry over  
ModPerl::RegistryBB.

RegistryBB is supposed to be a bit lighter (read faster) by not  
performing some checks
(according to the documentation), and appears to not break gitweb. So  
my question is
that I am wondering if this has come up in the past, or someone else  
knows a reason
why Registry should be used over RegistryBB (safety, breaks something  
I haven't
tried)?


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca
