From: Jakub Narebski <jnareb@gmail.com>
Subject: Annotating patches inside diff
Date: Wed, 10 Dec 2008 14:45:47 +0100
Message-ID: <200812101445.48034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 14:47:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAPPD-0004jY-MX
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 14:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbYLJNpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 08:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbYLJNpy
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 08:45:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:49606 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYLJNpx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 08:45:53 -0500
Received: by nf-out-0910.google.com with SMTP id d3so98342nfc.21
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 05:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=4lpodTWWB4smcdVv1bchV3SrFhREuQ9LmqeC4gyN2b0=;
        b=BSLEn1NaAgKL1XvqyicFkuN7cPNA6qq7pEQ0cro8/3pqhrInEJ1KZjmk3zvEG1VPC2
         WuoqHLuS0WT3pkX+MW2ijnm28j4j7ILtfLO29aoQEuzcJPUTmSVo5WXGazZuRHQ+rQXr
         3lQia9wTg8yZ2kCJvsiMWocR+dFY9iGlY0n0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=s/uZaBuBfXptx7+lQOVsIrMkUlRm6csJVxUU4j3cb9YG8KJ4HEP8EkYqevWNnE+Dd+
         /dAy/ZiPa/SZM0HKTXxdlmx7tfw8LP8jfIAjhuEnt505tI2DbvvLJmqX6w1W8nzXF1yA
         mh2bbAxgd8O6wwsjN7qx+kg9tCjV0YYJ3jw1s=
Received: by 10.67.96.9 with SMTP id y9mr4098582ugl.64.1228916750863;
        Wed, 10 Dec 2008 05:45:50 -0800 (PST)
Received: from ?192.168.1.11? (abxf60.neoplus.adsl.tpnet.pl [83.8.255.60])
        by mx.google.com with ESMTPS id r38sm8761377ugc.54.2008.12.10.05.45.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 05:45:49 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102686>

I remember that long time ago on git mailing list there was discussed 
extending git-apply and friends (including git-am), to be able to 
ignore lines in patches with selected special prefix, different from 
'@' for chunks headers, ' ' for context, '+'/'-' for added/deleted 
lines.  IIRC it was chose '|' for this purpose.

This way you could annotate patch

@@ -4667,7 +4667,6 @@ HTML
                                  hash_base => $parent_commit);
                print "<td class=\"linenr\">";
                print $cgi->a({ -href => "$blamed#l$orig_lineno",
| moved to <tr>
-                               -id => "l$lineno",
                                -class => "linenr" },
                              esc_html($lineno));
                print "</td>";


Was it accepted or dropped, or is this feature present but not 
documented?
-- 
Jakub Narebski
Poland
