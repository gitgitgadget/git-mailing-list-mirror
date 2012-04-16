From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [RFC/PATCH 1/2] update-index: add --clear option
Date: Mon, 16 Apr 2012 17:48:55 -0400
Message-ID: <20120416214855.GM12860@gmail.com>
References: <20120416152737.GB14724@sigill.intra.peff.net>
 <20120416160232.GA1350@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 23:49:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJtnJ-0000jg-0q
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 23:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679Ab2DPVtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 17:49:03 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:53482 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab2DPVtB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 17:49:01 -0400
Received: by qadc11 with SMTP id c11so3738391qad.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 14:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rvS/I6GGf3gkQBT8gD+qeKeR1TwGKqyd91HfgX/u4fc=;
        b=CblOQ3cy16KY7aSY4VlZCq4x7Rjkih2FnpHsYFeJG96H7AHhbu1Ve84kqdVtpXnAFE
         M8V6MCnscpxIF+y2kGtk/SoPlrIDQUlU2lXSKuJqIpzFiM+HtPscyR5sZbuX7RBDEj2t
         G1tZeH3snQvGQqqzzwRH9il9Cb+iwuJaotq1ZKK/t8TJ3mdVcWzdev9z+UO++HrDof7o
         eYv+/bzmrTZ85Mm9zPa0VbGGCoPg2RLoxsvdSQEkWHPKYy2P7yCFaMJvXNtUJzuiPVqm
         cOWLmitFI02HFKFQTILETfaclLxCXtZ1oTcX7tb/JAzsqepKzsgZIWo4UvdnpnhO4fhP
         lvbA==
Received: by 10.224.217.73 with SMTP id hl9mr12424095qab.99.1334612940672;
        Mon, 16 Apr 2012 14:49:00 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id gy7sm14263831qab.22.2012.04.16.14.48.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 14:48:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120416160232.GA1350@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195702>

On Mon, Apr 16, 2012 at 12:02:32PM -0400, Jeff King wrote:
> I tried to make something like:
> 
>   git update-index --from-scratch --index-info
> 
> work by avoiding reading all entries in the first place. However,
> update-index actually processes its arguments sequentially, so we _must_
> read the index before we start processing arguments. But because it's
> sequential, a "clear" operation makes sense, since you clear, then add
> new entries.

At the very least I can give this patch series a go this evening. I'm in
the process of combining 40 highly-intertwined, nested repositories into
one, and should be able to test it under the conditions outlined in the
updated example.

--
Christopher Tiwald
