From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] That works
Date: Thu, 17 Mar 2016 10:47:50 -0700
Message-ID: <1458236870-23464-1-git-send-email-sbeller@google.com>
References: <20160317020015.GC12830@sigill.intra.peff.net>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Thu Mar 17 18:50:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agc3w-0005j4-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 18:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031067AbcCQRuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 13:50:16 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33331 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932983AbcCQRuP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 13:50:15 -0400
Received: by mail-pf0-f178.google.com with SMTP id 124so130472987pfg.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HDdk38pZZJJ86r+A39D8WY6pYazZzYtvDZIlDgu2V4k=;
        b=HWTsSywvB+0rlMS3mwaJSnnoQEFr7+FUvZrllC9PSbjbQyyPLWgKrFIbS8G+SYVhbV
         5s8vSp/1f6oOZLoPNSP+e/G88RIDPJEmhZZPKrgKaHOOIyvOm6q7pjtJcNrC4O4p2Tmt
         UDA7dCnjRT2/txu9APuPKVtUVb/121kLDQGGi8damhx9b9Upkf8mpkj4Wb/RBgTNDEQk
         Jq9jMX0JaDDocYZAQIg8a5zMxEWQskCXcCw/GZJv+hbBaXGEFHrxt5cGt1JIO+aJIU8m
         PvqAJGF0Pm9APeKLjvLiIyCQ77g1ENaMJz2KKMvsPS7m8lXL+lgR2IvR7ifGnHmt9sMz
         ix7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HDdk38pZZJJ86r+A39D8WY6pYazZzYtvDZIlDgu2V4k=;
        b=b7i90tIdlV+4OXr5WhzcPbFFDJf7zULTKGe1xO4qqXwhLckotQ5rMVE83Cz67cMFT3
         1NZIr4tJoaF3hrUbQOMS9KqKeO+3ulhvh/jFnaBLQ0ekt9XHWF6BIbeX9incn5B3yMCA
         TLfJNFBzul4DgXOJcaxUfizASnp/ZkkEVaobNWIjba5kJ1h4hUG4pCtlX63CThzbhf1O
         ZHrE8t3Ean6hmNfo6qZpgkk14PRq88c1Z2FDNj2E5km8BqnoE/lxqwr1x535+MPsts5+
         C7//B9Z5j9/J+FSTgCiyw7v7o0U6e1j4cEtiRFpQMdUVj/xigtNitwoXof8sILWZAngP
         +Nxw==
X-Gm-Message-State: AD7BkJJnJxuvVvfZ3Xx9IcRzOEhXcr+u6jlyaNcJUmi+ZSZWF3ySgm6ns5XZiBzM+HKcBCtl
X-Received: by 10.66.102.104 with SMTP id fn8mr16879654pab.129.1458237014616;
        Thu, 17 Mar 2016 10:50:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d62:319:527b:e183])
        by smtp.gmail.com with ESMTPSA id g70sm14881441pfj.13.2016.03.17.10.50.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 10:50:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.1.g4c756e4.dirty
In-Reply-To: <20160317020015.GC12830@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289131>

sent from git-send-email with a corrupt .mailrc file.

Thanks,
Stefan


diff --git a/git-send-email.perl b/git-send-email.perl
index d356901..c45b22a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -533,7 +533,7 @@ my %parse_alias = (
 			$aliases{$alias} = \@addr
 		}}},
 	mailrc => sub { my $fh = shift; while (<$fh>) {
-		if (/^alias\s+(\S+)\s+(.*)$/) {
+		if (/^alias\s+(\S+)\s+(.*?)\s*$/) {
 			# spaces delimit multiple addresses
 			$aliases{$1} = [ quotewords('\s+', 0, $2) ];
 		}}},
