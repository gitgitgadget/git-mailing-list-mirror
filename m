From: Paolo Bonzini <bonzini@gnu.org>
Subject: [RFC] proposal for command "publish"
Date: Wed, 28 Feb 2007 14:49:43 +0100
Message-ID: <es419n$thr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 14:54:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMPG6-0004ya-H5
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 14:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbXB1NyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 08:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbXB1NyJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 08:54:09 -0500
Received: from main.gmane.org ([80.91.229.2]:39644 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbXB1NyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 08:54:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HMPBq-00033v-TY
	for git@vger.kernel.org; Wed, 28 Feb 2007 14:49:55 +0100
Received: from usilu-ge.ti-edu.ch ([195.176.176.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 14:49:54 +0100
Received: from bonzini by usilu-ge.ti-edu.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 14:49:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: usilu-ge.ti-edu.ch
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40923>

I'm proposing a command "publish", where

   git publish URL

would do

   git repack
   git clone --bare . URL
   git remote add origin URL

The idea is that this would be the step from preparing a repository 
(either from scratch, or importing from other SCM) to publishing it 
remotely.  Is this sensible?

Options from clone that would make sense for publish are -l, -q, 
--template, --upload-pack.

Paolo
