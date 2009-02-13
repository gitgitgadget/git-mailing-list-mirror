From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 0/4] remote HEAD improvements take 2
Date: Fri, 13 Feb 2009 03:57:13 -0500
Message-ID: <76718490902130057g4b05f87cn716bdf9769fda7bc@mail.gmail.com>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 09:58:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXtsh-0004Kt-ON
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 09:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169AbZBMI5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 03:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757913AbZBMI5P
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 03:57:15 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:44868 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139AbZBMI5O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 03:57:14 -0500
Received: by rv-out-0506.google.com with SMTP id g37so617592rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 00:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=LmIIydqBJIPv5TMx+6JhjBFdlDLaWqHGyDFEMRybKDU=;
        b=N1WNnsVtw7JpRWiC4ryQ8eTUiY3gk5cKL9wY2W2OGL/pAHw2e53yunMcUCUyl2D9DO
         8tEMt0RFfwOMltJfe72503dTw7y2OdOjzx3RIJ9TbeBb0juSpe1Vg40Hj+04jY6Zby0b
         FnuRImBhUU+2ubgsizeAphaOeF2/bpL2Wo40I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=D4eZdklZbNOSAe2lfxSKxf8CSt8drDzsmKNDfZB+Mh9Br/rowKsIYD2LP/G+aBU1qf
         M6UwmEfn64EYkafhdxxvffHdneX2wi59k/bLhwIVZWjSYBVOBe9BSNyH/Y3totPV5QvD
         +SVcBAykdcvzCOTqHUj+7pKTyFZBEPZ+nadFs=
Received: by 10.141.20.6 with SMTP id x6mr1047005rvi.40.1234515433817; Fri, 13 
	Feb 2009 00:57:13 -0800 (PST)
In-Reply-To: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109733>

On Fri, Feb 13, 2009 at 3:54 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> There is currently no porcelain for dealing with remote HEADs (i.e.
> $GIT_DIR/remotes/<remote>/HEAD). This series:

Crud, sorry for the duplicates.

And I just noticed a send-email bug -- it doesn't handle multiple Cc:
recipients the way they are formated by format-patch. e.g, format
patch does this:

Cc: firstperson@example.com,
    secondperson@example.com

But send-email only picks up the first address, and further, appears
to mangle it.

j.
