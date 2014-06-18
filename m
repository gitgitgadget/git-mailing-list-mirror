From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v18 16/48] refs.c: add an err argument to delete_ref_loose
Date: Thu, 19 Jun 2014 00:38:56 +0200
Message-ID: <53A21500.2050508@alum.mit.edu>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>	<1403020442-31049-17-git-send-email-sahlberg@google.com>	<53A1FAF8.4050700@alum.mit.edu> <CAL=YDWnbKTysV=OaDuxOz10=QbpSWkzmoYteSeq_-Fv=HtcOSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:39:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxOVT-000080-0B
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 00:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbaFRWi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 18:38:59 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57408 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752027AbaFRWi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 18:38:58 -0400
X-AuditID: 1207440d-f79c26d000000b51-d2-53a21502b0ea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F9.50.02897.20512A35; Wed, 18 Jun 2014 18:38:58 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB19A6.dip0.t-ipconnect.de [93.219.25.166])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5IMcuma001264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 18:38:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <CAL=YDWnbKTysV=OaDuxOz10=QbpSWkzmoYteSeq_-Fv=HtcOSQ@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqMskuijY4NkpYYuuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfG/fYVTAWXWCrefOFrYLzJ3MXIySEhYCLx79p2
	VghbTOLCvfVsXYxcHEIClxkl5s6ZwgThnGeS+PvvA2MXIwcHr4C2xILXsiANLAKqErNfnmQH
	sdkEdCUW9TQzgdiiAkESsz/PA4vzCghKnJz5hAXEFhHQlLjZfxqshllAX+LTnwNgtrCAn8SH
	1y+gFj9klJi/aR7YRZwCgRI/b3xmBdkrISAu0dMYBGIyC6hLrJ8nBDFGXmL72znMExgFZyHZ
	NguhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJTSjcxQsKWdwfj/3Uy
	hxgFOBiVeHgXXF4YLMSaWFZcmXuIUZKDSUmUd4fAomAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxK
	Irzyv4DKeVMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvA+EgYYKFqWm
	p1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2I3vhgYvSApHqC9W0DaeYsLEnOBohCtpxh1
	OU7dOdbGJMSSl5+XKiXOywlSJABSlFGaB7cClqReMYoDfSzMewSkigeY4OAmvQJawgS0RGXi
	PJAlJYkIKakGRq1ph99crfypKWSxfn+ed8ay5Gd7doZ8KNMwbMt7bt/65KKbXcOO74F6kl0L
	vNmdVxh2vc6MbJuttab0xPfL8WfPvfksamqgeDbI6MjiUws+2V5ZcH7pgaVaFkeu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252079>

On 06/19/2014 12:27 AM, Ronnie Sahlberg wrote:
> It looks like we need to reorder two of the patches.
> This patch needs to be moved to later in the series and happen after
> the delete_ref conversion :
> 
> refs.c: make delete_ref use a transaction
> refs.c: add an err argument to delete_ref_loose

That agrees with what I have found out since my first email.  The
failures go away starting with the later commit that you mentioned.

> I will respin a v19 with these patches reordered.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
