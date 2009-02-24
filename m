From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 11/13] remote.c: don't short-circuit match_refs() when 
	error in match_explicit_refs()
Date: Mon, 23 Feb 2009 22:07:36 -0500
Message-ID: <76718490902231907y6e37d1b5ud1c276860ca6324e@mail.gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
	 <6cbc71876488bd7e14db40560459c0e1b8ae7b37.1235368324.git.jaysoffian@gmail.com>
	 <7vhc2kpqh3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 04:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbnfN-00077u-Eo
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 04:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbZBXDHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 22:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbZBXDHj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 22:07:39 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:9732 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbZBXDHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 22:07:38 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2245801rvb.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 19:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X0TsWJklRHpyyI6xrjxeR0ggHBjVebMwzLcE0TUK0/8=;
        b=gOSYU+MVBZaD3q1abQ1VUDlx/jad+MGAGGjocf0ajYg30T+cpzd6qBbNwbW01M5md1
         hCkqiTlEbzUVXFfkDrLxbhxfLxNG4dSRJd7KBicBa30V2rqwlQC/UD9LOck4vfE+bhM4
         mxYZ981gdLKNEN/ioxy9n+GY4jztdi5BJf/dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cCgcsTyKTkdCsrUZeWVpQMHe9ROT0UeCCyxJgycTNBQNgPFD++p+fqav8m+InYk/zV
         U3l8ElXVpyvD3TNgAqJJNuDyzFvT/+KieFXZe7RPinX4fYUt3aQUGSFsPMjkJaWPvCRk
         sYKHsxgx7DP6jYBP4+FhxiCFHXcEONZWRXw1c=
Received: by 10.141.198.2 with SMTP id a2mr2304550rvq.297.1235444856722; Mon, 
	23 Feb 2009 19:07:36 -0800 (PST)
In-Reply-To: <7vhc2kpqh3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111200>

On Mon, Feb 23, 2009 at 8:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The same comment as 10/13 applies here.

As does the reply. :-)

j.
