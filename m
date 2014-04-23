From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 4/6] patch-id: make it stable against hunk reordering
Date: Wed, 23 Apr 2014 20:57:17 +0300
Message-ID: <20140423175717.GB28308@redhat.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
 <1398255277-26303-4-git-send-email-mst@redhat.com>
 <xmqq4n1k0wtw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:56:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd1PY-00074E-1e
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbaDWR4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:56:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35593 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbaDWR4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 13:56:34 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3NHuXE6003885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2014 13:56:33 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3NHuVwb022348;
	Wed, 23 Apr 2014 13:56:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4n1k0wtw.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246858>

On Wed, Apr 23, 2014 at 10:39:23AM -0700, Junio C Hamano wrote:
> Are these three patches the same as what has been queued on
> mt/patch-id-stable topic and cooking in 'next' for a few weeks?

Not exactly - at your request I implemented git config
options to control patch id behaviour.
Documentation and tests updated to match.
