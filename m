From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: Question about removing changes from the index
Date: Fri, 6 Feb 2009 14:57:35 +0100
Message-ID: <a1e915350902060557m5a67eba0q819c2ba2a0a49c21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 14:59:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVREX-0001Yw-Lx
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 14:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbZBFN5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 08:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbZBFN5i
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 08:57:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:35612 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbZBFN5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 08:57:37 -0500
Received: by fg-out-1718.google.com with SMTP id 16so508643fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 05:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=iD0eF7ofJKel2amJdxi9SDWZf6zCTFXDXxbbGFOOXJI=;
        b=cylesNOtkzN2HYUFFkWQ4lHvn6nrt5qGbsvq9te3pm8T+anCk2qLQy7obldueFRd5w
         q7d43qX7hEN4GpQzTqbEQrdSPWOStTOZzI5nZuY1cqg2x/eCJQAWjSSoueQDXaLdH+xB
         5hPyU5TXUrJV2D8fU+l9lYdsVMfJ6AXW6khvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=gKt/UTTMEI/jdlePv99rhBMECCervb2qoHXx6xou4bUdlN4rXqAObp57EbTVt3QMN/
         wi8QxKkEjtGAw0hIzusEVFQ0qFW4+YMEzLst9ayAcscoNhDvi2H9s5FOH+vb5DpBF9fx
         Vy4mzqoDSWch2pZDcapJl40lfC6iQXCgFvIMY=
Received: by 10.180.231.17 with SMTP id d17mr601275bkh.37.1233928655539; Fri, 
	06 Feb 2009 05:57:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108707>

I'm wondering if there's anyone who can recommend a smart way to
"reset" the index entry for individual files to the contents of HEAD,
in effect, removing any previous change between HEAD and the index
(for those files).

I'm aware that 'git gui' lets you do this (in a human-friendly way)
but I want to do this from a script (and am not concerned about the
human-friendliness, as long as it's not too programmer-unfriendly).

Thanks,
Gustav
