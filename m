From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: blame vs annotate?
Date: Wed, 3 Sep 2008 17:43:03 +0100
Message-ID: <57518fd10809030943i35af222fw82cf591c737b8c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 18:44:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KavSn-0002ol-Bj
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 18:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYICQnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 12:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbYICQnG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 12:43:06 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:38963 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbYICQnF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 12:43:05 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1666164yxm.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=3Xxb6IhM+PEBbLFZVYiylEoEXkJqbqUsqxi1drc0HVY=;
        b=Rjw5aBl1i9r9Wpv0gJ/hmkNtuBqjAN1hJeCjGMUnLoRcuTFjaf2I6XWXaHhhEs+Tly
         e8RejhlQnICVsMxk3DYSg8q7az+Enla7oEmuaweAg/m1XIsvMMhWtLP+taIKq/Opm08C
         fpeRy5/x+PpVlzYgO9Mf8Auy6iQ2U7UBFHyxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=DwkGyMlNS1LomxjjDu1s7HSeqeTbYtalmRTpe+x957ffRLI/zXminuPrXo/8ywq8J2
         eO3U6fJQvezfzwk5EOtgki39KI6cb6jbg6Sh+rw/Kf/n7PzZvRTFUbvpjCX6y/G2lSkQ
         5QJEiwtXn1+TkI/eShFdA/zN9YKvpRY269Kv0=
Received: by 10.142.14.18 with SMTP id 18mr3124338wfn.129.1220460183894;
        Wed, 03 Sep 2008 09:43:03 -0700 (PDT)
Received: by 10.142.70.18 with HTTP; Wed, 3 Sep 2008 09:43:03 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 46280fa4d20ce20e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94811>

What's the difference between 'git blame' & 'git annotate'?  The
output is practically identical - it's not obvious when you would use
one over the other
