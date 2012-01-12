From: lists@haller-berlin.de (Stefan Haller)
Subject: Zsh completion regression
Date: Thu, 12 Jan 2012 12:52:27 +0100
Message-ID: <1kdr5xk.1sopzul1hygnbrM%lists@haller-berlin.de>
Cc: szeder@ira.uka.de (=?ISO-8859-1?Q?SZEDER_G=E1bor?=)
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 12:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlJEi-0007Hx-4N
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 12:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab2ALLyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 06:54:21 -0500
Received: from server90.greatnet.de ([83.133.96.186]:50281 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2ALLyV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 06:54:21 -0500
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id F23672A0548;
	Thu, 12 Jan 2012 12:50:36 +0100 (CET)
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188443>

I'm using zsh   4.3.11.

When I type "git log mas<TAB>", it completes to "git log master\ " (a
backslash, a space, and then the cursor).

Bisecting points to "a31e626 completion: optimize refs completion."
Before this commit, I get "git log master" (with no space at the end).

My completion-fu is not strong enough to dig into this myself, but I'll
be happy to help test, or do whatever else helps.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
