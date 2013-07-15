From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/6] t4000-diff-format.sh: modernize style
Date: Mon, 15 Jul 2013 11:00:09 -0700
Message-ID: <20130715180009.GD14690@google.com>
References: <20130715173536.GB14690@google.com>
 <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
 <1373910925-18422-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 20:00:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyn4T-0006gP-PN
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 20:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab3GOSAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 14:00:14 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:53244 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab3GOSAN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 14:00:13 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so10918452pdj.36
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CRV12f3jXTFiPm1ij0Bxzlia3igu45pHEP0ldMOanZE=;
        b=H3qa1P+sFspMUcmPTpxBF9JlwAs8kYIHnmfyyZ2ZyVfb85w0Ovlg2Y9328hHMYRD4Y
         BzVRoyuiiOgTpFnJE91ylS0+0V33WHVzahcTfQThmgxMccsVnshY1anbSK9fPFE4ZeAB
         4VnqwOiXC/Z2yOk8nothVC/mxMep8wkjMBE/5mkdZGksGb8qdSCyYK1EJXfFMujoKqVK
         f8HVcy/bDAm3jxC2HE2GZ5xyU/34vjfBm9sctVmjoCG5+Up9LFZ8JBuZMxL/I38Sa2gq
         D3BQt9dLB5WYpr83Z/5LqLmT9k5pnv7YJscrbtIQYGBef1+5kNo8oF6fZ+Arb/KXK7jR
         uI5w==
X-Received: by 10.68.35.131 with SMTP id h3mr30955186pbj.140.1373911212830;
        Mon, 15 Jul 2013 11:00:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pq1sm19100880pbb.26.2013.07.15.11.00.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 11:00:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373910925-18422-2-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230510>

Matthieu Moy wrote:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  t/t4000-diff-format.sh | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

This test script can use more cleanup, but as preparation for later
patches in this series the above is enough. :)  If I forget to do more
cleanup as a followup, feel free to kick me.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
