From: Paul Walker <PWalker752@aol.com>
Subject: installation issue when building with NO_CURL=YesPlease
Date: Wed, 26 May 2010 14:35:03 +0100
Message-ID: <5B1E2CF0-4BC4-43FF-A372-EB3582DA6286@aol.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 15:35:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHGlb-0002oS-LE
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 15:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab0EZNfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 09:35:22 -0400
Received: from imr-ma03.mx.aol.com ([64.12.206.41]:35349 "EHLO
	imr-ma03.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab0EZNfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 09:35:21 -0400
Received: from mtaout-ma03.r1000.mx.aol.com (mtaout-ma03.r1000.mx.aol.com [172.29.41.3])
	by imr-ma03.mx.aol.com (8.14.1/8.14.1) with ESMTP id o4QDZFjY012960
	for <git@vger.kernel.org>; Wed, 26 May 2010 09:35:15 -0400
Received: from paulw-laptop.stglab.manchester.uk.ibm.com (gbibp9ph1--blueice1n1.emea.ibm.com [195.212.29.67])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mtaout-ma03.r1000.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id 55A12E0000B4
	for <git@vger.kernel.org>; Wed, 26 May 2010 09:35:15 -0400 (EDT)
X-Mailer: Apple Mail (2.936)
x-aol-global-disposition: G
X-AOL-SCOLL-SCORE: 0:2:386140480:93952408  
X-AOL-SCOLL-URL_COUNT: 0  
x-aol-sid: 3039ac1d29034bfd23937e02
X-AOL-IP: 195.212.29.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147796>

As I could not find any bug reporting information on the wiki I  
thought I would mention this here, please let me know if there is a  
better forum for bug reports.  I believe the latest git release  
(1.7.1.) has an installation bug when building with  
"NO_CURL=YesPlease".  Looking at the Makefile line 1999 it reads

for p in $(REMOTE_CURL_ALIASES); do

which results in "/bin/sh: syntax error at line 1 : `;' unexpected" as  
REMOTE_CURL_ALIASES is empty.
