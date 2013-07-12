From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH v2] Corrections to the mailmap file
Date: Fri, 12 Jul 2013 13:49:28 +0200
Message-ID: <1373629769-23647-1-git-send-email-stefanbeller@googlemail.com>
References: <7vzjttq9wk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 13:49:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxbr2-0005Dz-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 13:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929Ab3GLLtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 07:49:36 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38025 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932834Ab3GLLtf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 07:49:35 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj3so569471wib.16
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hyeA0cRdLl6xFKpm1i0qFYvIumfmCn8uKaj4pQlnRp8=;
        b=xglXEPr3BU9yPuAC7xWrEXkkrSVXSXFc+jh6NOXhuTFDdhov/T8IZ2dCcOxQpP1BO7
         l8m5/zUliIqbh8uIr92hJMOJ6pw6b95Xr1RfvREOnkK2SatM9AmV9grWuRaFRFAJKe9s
         zTJMOUxEyfy+GJrxifAO0PneZZpsshVCcTkcRfJ7kZHpGpysaQtk9m71MkjDTBRzE8I6
         uzKEDlitx7OVGY6HEW1H9v36tQsk3W8qOlTdwuUrN58VIJOkWB7zRSNWS6JZaEGZqErd
         DppSK2zLSeGTZ0r6GOsH01adIfz5w3M95r4HyyMLvYgH5N43DDCTYeI0f/23isznlgh6
         GypA==
X-Received: by 10.195.13.195 with SMTP id fa3mr23705066wjd.80.1373629774323;
        Fri, 12 Jul 2013 04:49:34 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id w4sm2884379wia.9.2013.07.12.04.49.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 04:49:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.636.g7943f03
In-Reply-To: <7vzjttq9wk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230195>

By now I contacted more than half the people, who might
get some .mailmap entries. Not all of them have responded,
but maybe 2/3 of those, whom I contacted.

I used 2 branches to get this work done. One branch having
all the proposed patches, where each patch just changes one
name, so I can send it to that specific person for review.
The second branch would be slightly behind the first branch
and only have the patches of the confirmed .mailmap changes.
The following patch is a squashed version of the confirmed 
branch.

Whenever somebody confirmed their patch, I'd include it
into the confirmed branch and rebase the first branch on top
of it. That works fine, if there are no many commits
in between, so no merge conflicts occur.

Junio, therefore I'd ask to include the following patch as 
the 1/3 milestone in the mailmap completion, so the number of
my local patches floating around is reduced.

The 6 patches sent at 4th July are not required anymore,
but the following patch directly applies to your master branch.

Stefan Beller (1):
  .mailmap: Map email addresses to names

 .mailmap | 95 ++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 24 deletions(-)

-- 
1.8.3.2.636.g7943f03
