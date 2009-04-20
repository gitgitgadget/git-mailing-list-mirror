From: Michael Witten <mfwitten@gmail.com>
Subject: Oldest supported Perl version
Date: Mon, 20 Apr 2009 08:43:27 -0700 (PDT)
Message-ID: <49ec981f.1e038e0a.2c74.fffff13c@mx.google.com>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 17:45:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvvg6-0000GR-Cn
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 17:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbZDTPna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 11:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbZDTPn3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 11:43:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:4731 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbZDTPn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 11:43:29 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1913229wff.4
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:cc
         :subject:in-reply-to:references;
        bh=5QNUSMBPks/zgbsOgSpVEv9g6SN9Y2OF9qP+pB3c484=;
        b=YDiFL0Z6fs/lTTX1u6oOa+gGyROEWMBWeZg9aTos2epppavcJgLaraBWha/X8E18FN
         g2xLY48enBsKxcJbOdr3v+Hi2XT2EwK4mMWaf4vr6QVVl4aK6Po2dCVL9IihG36dLZ1H
         5eBtRcuPlG54rZw6+CZu2x5q8TM4tj7ZHZbHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:cc:subject:in-reply-to:references;
        b=X33JzXVTX8NGC23McuJkYV97i9Zj8Mrz7WxlNdsb20sdwuyL0rTUftJjj6o9b7G9Dm
         IQ8XPZusHT+S9z3zjO5lDQK97iDiqwX6L1lg8CZVateFxK0bTw6crL7v19ZUXrpJr9bf
         OpYWtHdg2+vJpuWnt/O7LCNxf/+osm1IR3gj8=
Received: by 10.143.29.18 with SMTP id g18mr4438246wfj.297.1240242208328;
        Mon, 20 Apr 2009 08:43:28 -0700 (PDT)
Received: from gmail.com (97-116-107-50.mpls.qwest.net [97.116.107.50])
        by mx.google.com with ESMTPS id 30sm17197023wfc.4.2009.04.20.08.43.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 08:43:27 -0700 (PDT)
In-Reply-To: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117001>

====> Sorry for the repeat; I think I'll go install an MUA now.

On Mon, Apr 20, 2009 at 09:59, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Sun, Apr 19, 2009 at 9:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Sorry, I should have checked myself.  defined-or "//" is 5.8.1 or later.

>From what I've read:

	http://perldoc.perl.org/perl581delta.html#Future-Directions

The defined-OR only exists for 5.8.1 in patch form, and it's only directly
supported in 5.10.0:

	http://perldoc.perl.org/perldelta.html#Defined-or-operator

:-(
