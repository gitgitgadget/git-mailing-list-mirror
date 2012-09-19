From: Hong Xu <dev@hong.me>
Subject: Add .editorconfig file to source repository to maintain a consistent coding style
Date: Wed, 19 Sep 2012 00:31:39 -0700
Message-ID: <64033A69-B5AA-461A-80B4-F143E4FC1614@hong.me>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1486\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 09:31:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEElD-00062v-BI
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 09:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab2ISHbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 03:31:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64331 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab2ISHbm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2012 03:31:42 -0400
Received: by pbbrr13 with SMTP id rr13so1822917pbb.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 00:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version:x-mailer:x-gm-message-state;
        bh=eh8x95UMfvsotcin8wlSCYSMraOaUa4+r9c1KX5RMXo=;
        b=WOD47okwlWRUqIweGjJ05qz5D5BfsBTlFlefkejzorRpHXETWxY1qAggTZT36fs/sF
         myTpr0jddmK2kzoNtai1aP8pGUBA3od4X90SZtazSXC7unTLGlLoRwowvLkJL74y3BcX
         R+xlH4Kec0P8BVLCBJBHZxclPFKDcTdXxyIK68S0z+n8Suw+4hqrVKSl1/70PzSDfu3F
         hW2bznVWR9XczGsHqUa3CImI8Il25G73nxeVJhTC6kOIvLTOS628k7VlGRPc3cU6wmn6
         hMfMiq2LtqjricgsVto4uTDeU32rMOiap/KAVZnaRdeGIqjG1RBw2k5oYQ7azgXODzyj
         3Guw==
Received: by 10.68.237.38 with SMTP id uz6mr5307208pbc.23.1348039901788;
        Wed, 19 Sep 2012 00:31:41 -0700 (PDT)
Received: from [192.168.0.2] (cpe-76-169-182-35.socal.res.rr.com. [76.169.182.35])
        by mx.google.com with ESMTPS id hc10sm1386540pbc.21.2012.09.19.00.31.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 00:31:41 -0700 (PDT)
X-Mailer: Apple Mail (2.1486)
X-Gm-Message-State: ALoCoQkJk5t7A6msY4jmR/uo5KHhz7/J4QMnWjUeMPJyYYY2WMVMLwVJwmwQ16QujL3NdkrcP/DD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205913>

Hi all,

EditorConfig <http://editorconfig.org> is a project that helps developers define and maintain consistent coding styles between different editors and IDEs. The EditorConfig project consists of a file format for defining coding styles and a collection of text editor plugins that enable editors to read the file format and adhere to defined styles. EditorConfig files are easily readable and they work nicely with version control systems.

EditorConfig has been used in many large and famous projects, such as Ruby, jQuery, etc. I think the Git community may also find it useful, since there are some inconsistent indentation in the source code. 

What do you think about this?

Best,
Hong