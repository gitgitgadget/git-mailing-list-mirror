From: Joseph Pecoraro <pecoraro@apple.com>
Subject: `git help svn` missing description of `propset`
Date: Mon, 06 Jun 2016 23:24:47 -0700
Message-ID: <2A4EC08B-3095-4063-BDF3-5B1CD1CEA2C3@apple.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 08:39:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAAgA-0004Xa-OY
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 08:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbcFGGjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 02:39:55 -0400
Received: from mail-out6.apple.com ([17.151.62.28]:42439 "EHLO
	mail-in6.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751031AbcFGGjy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 02:39:54 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jun 2016 02:39:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
	q=dns/txt; i=@apple.com; t=1465280687; x=2329194287;
	h=From:Sender:Reply-To:Subject:Date:Message-id:To:Cc:MIME-version:Content-type:
	Content-transfer-encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P2cPhakbQI7SS+ik7ozFyL93rE5rs7zmTmQnbY9MQb8=;
	b=hyLHjuPz925S70KbxMiwfZo3aKp8Uu2rKO84KXmzrdqoQTBzgO9YvAkH9JsFzjzm
	XjH16x2shbUqpXoPZPSyH7zlaukv2eYN1trLTxlfbjWnh2xJ96CiWBqELSZHrLdS
	rtZSMaoQo7DcZMjJWBynU3TcoxGsWWPteNiLFez4NB5MYO4hwkW07zn1VcEU6/so
	q2oCYs50fJgwlXlc5LUhoN3Dm0FR+5QGXPsGw4fu8KZck8fQh5KZMxpqlaPUmoOI
	EQRnIPv1JE1Bhy/aNJ5uzSmIEi8xSvIueh/e4G/8gyP5yXoBeLqb3kKBMB40gwKH
	KBAh2UvpbIR+oJvFgb6EIw==;
Received: from relay6.apple.com (relay6.apple.com [17.128.113.90])
	by mail-in6.apple.com (Apple Secure Mail Relay) with SMTP id 03.A3.27179.FA866575; Mon,  6 Jun 2016 23:24:47 -0700 (PDT)
X-AuditID: 11973e15-f79686d000006a2b-a9-575668afc479
Received: from chive.apple.com (chive.apple.com [17.128.115.15])
	(using TLS with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by relay6.apple.com (Apple SCV relay) with SMTP id F0.61.28643.FA866575; Mon,  6 Jun 2016 23:24:47 -0700 (PDT)
Received: from pecoraro.apple.com ([17.202.44.84])
 by chive.apple.com (Oracle Communications Messaging Server 7.0.5.35.0 64bit
 (built Mar 31 2015)) with ESMTPSA id <0O8E00JKE1TBFI50@chive.apple.com> for
 git@vger.kernel.org; Mon, 06 Jun 2016 23:24:47 -0700 (PDT)
X-Mailer: Apple Mail (2.3124)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsUi2FAYpbs+Iyzc4NJtE4uuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGXc3d3HXrCXo+LEvA9sDYwHWbsYOTkkBEwkHn5YwAZhi0lcuLce
	yObiEBLYyygx62orUBEHWNHV2cUQ8WlMEv/+/WWHcLqZJHrPvAbrFhaQktg+rYUJxGYT0JJ4
	sKERzGYGstfvPA5la0s8eXeBFaLeQuLUuTVgvbwCNhKb50wDs1kEVCUWfV3HAmKLCIhLvD0+
	kx2iRk9i8tEGqEtlJZ6cXMQCYZ9llVjdGTiBUXAWknWzkKybhaR9ASPzKkah3MTMHN3MPDO9
	xIKCnFS95PzcTYygoJxuJ7qD8cwqq0OMAhyMSjy8At9Dw4VYE8uKK3MPMUpzsCiJ8+65BRQS
	SE8sSc1OTS1ILYovKs1JLT7EyMTBKdXA2Lu1b/PysqXWVYVfVu0OM52b4TvtKg/3wYXZ/a/P
	lKxW+rVh45u50XqyxTkyQXMcxL9o6m9k+XtK+4daippa0vaXU043S/Dce2mTI/BK9x/jNB+r
	MoXjHxrSogVcApMsJ2TNnP3kZnPEqrWC10/rR7J/9Z277W1K6qYen7eHv7QdyKh4FWhjocRS
	nJFoqMVcVJwIAMkErU0rAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42IRbCjm112fERZucHSHkUXXlW4mB0aPz5vk
	AhijuGxSUnMyy1KL9O0SuDLu7u5jL9jLUXFi3ge2BsaDrF2MHBwSAiYSV2cXdzFyApliEhfu
	rWfrYuTiEBKYxiTx799fdginm0mi98xrNpAqYQEpie3TWphAbDYBLYkHGxrBbGYge/3O41C2
	tsSTdxdYIeotJE6dWwPWyytgI7F5zjQwm0VAVWLR13UsILaIgLjE2+Mz2SFq9CQmH21gg7hI
	VuLJyUUsExj5ZiFZMQvJillIWhYwMq9iFChKzUmsNNNLLCjISdVLzs/dxAgOo8KoHYwNy60O
	MQpwMCrx8Ap8Dw0XYk0sK67MPcQowcGsJMJ7PS0sXIg3JbGyKrUoP76oNCe1+BCjNAeLkjhv
	hBBQSiA9sSQ1OzW1ILUIJsvEwSnVwCiev/DLLm7L5Nts9av/MNyfYW7q7Jtg6mQ3x9789fU5
	slJulbayakY1Pg8/CXfOsA0XOBPeMvPTUml2+309j0V/57gma3rcmLzk55/zh98zzVPuX3Tt
	qyDrlIqJ6xp2uul33f79m8uis31Orn/tyVh3BaObsQHmuZf1JCuDl783ZWtLll7br8RSnJFo
	qMVcVJwIAPxNEoAfAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296603>

`git help svn` does not mention `propset` but it does mention `proplist` and `propget`. This seems like an oversight.


    $ git help svn
    ...
        proplist
            Lists the properties stored in the Subversion repository about a given file or directory.
            Use -r/--revision to refer to a specific Subversion revision.
        
        propget
            Gets the Subversion property given as the first argument, for a file. A specific revision
            can be specified with -r/--revision.
    ...


Interestingly, the generic `git svn` help does mention `propset`.


    $ git svn
    ...
      propget          Print the value of a property on a file or directory
                         --revision, -r <num>
      proplist         List all properties of a file or directory
                         --revision, -r <num>
      propset          Set the value of a property on a file or directory - will be set on commit
    ...
  
It seems Documentation/git-svn.txt is missing text for `propset`.

- Joe