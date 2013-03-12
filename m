From: Scott Haynes <scottnc27603@gmail.com>
Subject: git files from another branch in a separate repository
Date: Mon, 11 Mar 2013 22:22:00 -0400
Message-ID: <00DCB4A6-DBB3-4B9B-94ED-EA8792769C05@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 03:27:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFEwK-0006jq-SC
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 03:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab3CLC1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 22:27:18 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:35169 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab3CLC1R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Mar 2013 22:27:17 -0400
Received: by mail-yh0-f42.google.com with SMTP id w49so758656yhw.15
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 19:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:content-type:content-transfer-encoding:subject
         :message-id:date:to:mime-version:x-mailer;
        bh=q1I1lvqXzdVOxiJsulIEBbpqfpT2zF/Rn+BwMdrIW8g=;
        b=sKpSsrXr8JjL1ikPZpVlefAbUGT3VWUd8BNdMqQwP2HBMx2jYo8Tc4Gu9+F9TC66oS
         rpGcJSERL9tzWhrbhDaiExOAsNQsLNyyT/BAtp3MnwL3qck8TBnD0ozL8w1puBtO51sR
         LL633miAt8zqWafqhNG/KC0RG1E+Enfp3qh2n4MgUQ4hIk2n7LsyxKEMj4frm1DbenUO
         0exFXxQ7ITiKqDt4r+KRgYcPgbo4Ha0o27tnckxT6t+iIPVe6o1lS7dQmtZETeuocZWy
         8lyZ8cD0MVcpUGx712oj+5jr6GbCwXkFeNjduy9h2PClOWSBu0Wh25VCo5vNQUEUU3A8
         eIDw==
X-Received: by 10.236.118.78 with SMTP id k54mr11313685yhh.30.1363054923009;
        Mon, 11 Mar 2013 19:22:03 -0700 (PDT)
Received: from [192.168.0.122] (cpe-174-109-008-234.nc.res.rr.com. [174.109.8.234])
        by mx.google.com with ESMTPS id j23sm14914782yha.3.2013.03.11.19.22.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 19:22:02 -0700 (PDT)
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217934>

I'm currently working on a git project( vwf - virtualworldframework ), and we need to get a couple of files from another repository( threes ).  We've forked threejs into our repository, but I need to be able to grab only those few files that I need.  I thought I wanted to do a sub-tree merge, but after reading about the -tree options, I don't think that is what I need to do.  Do I want to right a hook script to pull in those files?

TIA,
Scott