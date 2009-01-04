From: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
Subject: Re: [EGIT PATCH] Fixed trivial warnings. Mainly parametrized raw
 types,   added serialVersionUID, removed unnecessery throws.
Date: Mon, 05 Jan 2009 01:26:02 +0200
Message-ID: <gjrgip$al9$1@ger.gmane.org>
References: <gjrcni$9q$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 00:27:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJcNr-0002Z5-Mg
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 00:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbZADX03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 18:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbZADX03
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 18:26:29 -0500
Received: from main.gmane.org ([80.91.229.2]:42812 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbZADX03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 18:26:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LJcMU-0002Mz-B3
	for git@vger.kernel.org; Sun, 04 Jan 2009 23:26:27 +0000
Received: from 91.200.115.178 ([91.200.115.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 23:26:26 +0000
Received: from vvavrychuk by 91.200.115.178 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 23:26:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91.200.115.178
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <gjrcni$9q$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104552>

Not sure what is right:
public abstract class AnyObjectId implements Comparable<ObjectId> {
or
public abstract class AnyObjectId implements Comparable<AnyObjectId> {

IMHO second, but class AnyObjectId contains some compareTo(ObjectId).

Also not sure if this bunch of changes is complete enough. Maybe it's better to make more fixes in this direction and then commit.
