From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: git interpret-trailers with multiple keys
Date: Wed, 6 Apr 2016 19:12:56 +0300
Message-ID: <20160406191054-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 18:13:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anq4m-0001wg-5I
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 18:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbcDFQM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 12:12:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38716 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbcDFQM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 12:12:59 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A024E6F694;
	Wed,  6 Apr 2016 16:12:58 +0000 (UTC)
Received: from redhat.com (vpn1-7-173.ams2.redhat.com [10.36.7.173])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u36GCuoi026230;
	Wed, 6 Apr 2016 12:12:57 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290845>

I have this in .git/config

[trailer "r"]
        key = Reviewed-by
        command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
[trailer "s"]
        key = Signed-off-by
        command = "echo \"Michael S. Tsirkin <mst@redhat.com\""

whenever I run git interpret-trailers -t r I see these lines added:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com
Reviewed-by: Michael S. Tsirkin <mst@redhat.com

Why is Reviewed-by repeated?  Bug or feature?

-- 
MST
