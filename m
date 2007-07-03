From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Can git-svn treat specify paths as branches ?
Date: Tue, 3 Jul 2007 17:12:49 +0800
Message-ID: <4b3406f0707030212h1e029023sf74c5c7b0e95654b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 11:12:56 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5eRL-0001Rx-9U
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 11:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbXGCJMv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 05:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbXGCJMv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 05:12:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:35374 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbXGCJMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 05:12:50 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1740200wxd
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 02:12:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hGx3kLpdGQTEWs0cf81K3mI+f8rLoxeGy0REnrO0X3dw9hqrUt2nbR3zK2Y56KSUXpKxal1FDT3eihyGtywb6pMUOyFNJG9E73DTadNYjUxiglDkMJ3ntTDohJb9qtp/UVj1tKFWPYDybRU4tj12c6wmOlYitGjVkvPePoy+b44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Mt/qddfYj2vQhlqOOXmHkBHMMXVVQ0ixqC+x9if+K/KUosICLUmwv7iw1M4wkuGDUe6LOxt8sJdiTyR1eHNup7YHQrVandJarUvy/FtVTYXnqy7qKFBnZmcrIwV3uy4Ur4J933vikOfX0WwTpaenXI4Y4zmXF8Kh91gDxZw2waY=
Received: by 10.70.105.19 with SMTP id d19mr6669112wxc.1183453970018;
        Tue, 03 Jul 2007 02:12:50 -0700 (PDT)
Received: by 10.70.43.18 with HTTP; Tue, 3 Jul 2007 02:12:49 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51470>

For google code projects, the repositories organized is:

branches  tags  trunk  wiki

Can I treat wiki as a branch? i.e.

[svn-remote "svn"]
        url = http://serf.googlecode.com/svn
        fetch = trunk:refs/remotes/trunk
        branches = branches/*,wiki:refs/remotes/*
        tags = tags/*:refs/remotes/tags/*

---
Dongsheng
