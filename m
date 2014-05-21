From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 14:50:59 -0700
Message-ID: <20140521215059.GB13956@hudson.localdomain>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
 <1400634170-18266-2-git-send-email-jmmahler@gmail.com>
 <xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 23:51:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEQX-0007t4-8K
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbaEUVvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:51:53 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:50941 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbaEUVvD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:51:03 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so1807930pbc.4
        for <git@vger.kernel.org>; Wed, 21 May 2014 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QFkih6HXfICNikYB8MvI3ZGpNvePYZWriZypXkcpymA=;
        b=aBFdYapGGAZjWgCeToemXqUXTZ8ligY6+cLQaN1eBvrQCcthznnjMDrNIEk5VZXlq3
         x+RzunwhpQ12a6mGbmkOkgv8APl7vSQxX4Vg12H7JGx+aF0bCOizN867uREB1eQPqDV/
         AGtVGDeGxpaYj258P2Zn49K5ONfPJNmEIqsAL2Q0aZ4AX11fWttgg4LO4/SEoyLd+8Ol
         5g0FDzSmDzDSiUlVSrUgAAGceUxO9MPqwrGQ6V+sMneA2YU44ytf7v/9E+6/5NQNynJH
         Xhbkkz31jLQ2IbG0m/zzcwvRm1i5Ax4k9K0hFMl3ek3EyW9qYl9Sz7TkTRqPUs4wz5U1
         gn9w==
X-Received: by 10.68.201.10 with SMTP id jw10mr61828851pbc.25.1400709063371;
        Wed, 21 May 2014 14:51:03 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id jq6sm9660745pbb.76.2014.05.21.14.50.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 14:51:01 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 14:50:59 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249840>

On Wed, May 21, 2014 at 02:13:06PM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
...
> >  	! grep "^-- \$" output
...
> 
> We have been trying not to do the above in recent test updates.  It
> would be nice if this set-up did not have to be outside of the usual
> test_expect_success structure.
> 

Jeff caught those "! grep" instances in my patch.

I can submit a separate patch to fix instances like those in test cases
unrelated to this signature-file patch.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
