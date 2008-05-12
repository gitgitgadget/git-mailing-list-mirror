From: Thomas Hunger <hto@arcor.de>
Subject: multiple files for the same hook
Date: Mon, 12 May 2008 20:39:49 +0000
Message-ID: <200805122039.49779.hto@arcor.de>
Reply-To: hto@arcor.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:41:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvepW-0001Jj-Mz
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbYELUkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756419AbYELUkF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:40:05 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:46033 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753302AbYELUkE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2008 16:40:04 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 72A2124B116
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:40:02 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 13CA32D4377
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:39:47 +0200 (CEST)
Received: from [192.168.1.101] (cpc1-cmbg11-0-0-cust771.cmbg.cable.ntl.com [86.22.75.4])
	(Authenticated sender: thuner@arcor.de)
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 2091826D364
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:40:02 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92.1/7104/Mon May 12 20:15:41 2008 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81944>

Hi,

we use hooks a lot for various cleanup tasks, tests and warnings. It 
would be wonderful if we could keep the hook logic in separate files. 

Something like

    hooks/post-commit.d/

where all executable files in the dir are executed in alphanumeric 
order. Is there a possibility of this going into git (I could try a 
patch)?

Tom
