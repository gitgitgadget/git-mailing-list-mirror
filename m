From: eschvoca <eschvoca@gmail.com>
Subject: How do I clear the directory cache
Date: Mon, 17 Oct 2005 10:20:42 -0400
Message-ID: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Oct 17 16:23:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERVr6-0006hd-EH
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 16:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVJQOUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 10:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVJQOUo
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 10:20:44 -0400
Received: from qproxy.gmail.com ([72.14.204.193]:22927 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751378AbVJQOUo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 10:20:44 -0400
Received: by qproxy.gmail.com with SMTP id u24so234362qbh
        for <git@vger.kernel.org>; Mon, 17 Oct 2005 07:20:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=osmJ3rVHWR5Ab+FiFIVlwBFW4AvhPJcPSSyOFldiDc7+lzs+MtDdBpABrKDmPq3oVWjLyNuwIJpTL+5xn45PrW/+M5X6v0RnuhhJUJQL75cs6fSoMBO+A/fuoApBENXhfl+CTi7BzgOjE7peH0KNwo2u+HD1yLZNjtykBmvlRI0=
Received: by 10.64.204.12 with SMTP id b12mr2025320qbg;
        Mon, 17 Oct 2005 07:20:42 -0700 (PDT)
Received: by 10.65.44.2 with HTTP; Mon, 17 Oct 2005 07:20:42 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10184>

Hi,

If I do a:

cg-commit
modifiy some files
cg-rm <modified files>
cg-add <a new file>
cg-rm <a unmodified file>

Then how do I get back and undo all of the cg-adds and cg-rms?  I want
cg-status to show the the changes from my commit and my current
working tree.

Thanks.

e
