From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Merging two projects
Date: Mon, 3 Nov 2008 19:33:21 -0800
Message-ID: <216e54900811031933n346e8c68se9226e79366c3eb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 04:34:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxCgf-0000vQ-Lt
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 04:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbYKDDdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 22:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYKDDdY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 22:33:24 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:46001 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbYKDDdX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 22:33:23 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1104102yxm.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 19:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=kqMZ4jQlFT8dqCX/ajEjRPtQT275NDCxW8+pUk3ifDg=;
        b=vXaIiemrMebEZT/ObUxb/gaxUeKiB//wQVo9wI8XfJz8ICa5uA9wuCSbfKvjqv4Ffi
         43er8QMx2rouwNdpHXR/IT761c0h73Bvj2aIaXyey1z6/fx1Pn1DLWh59ybb7O36TX88
         mffRquW8FT81dnTvUDMnr3QyeA6B9hSHNLxH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Fy+eMP92AdXD31NIoG6gGJEAoPpeYO15gb4wu9aAfmAkVshfHIJyhUNCCtlWOhmKNy
         z9j3FXP1JRSrmhgwnLJ9iiIFNMDXtn1r6Z7eo9ZMYosn7JH5erHIhgbv5n5oFH3pZd7z
         hJd8DO7J4V2mI4KBlSWKIP6NdZP4oIEFzbZUI=
Received: by 10.151.114.9 with SMTP id r9mr1539714ybm.157.1225769602014;
        Mon, 03 Nov 2008 19:33:22 -0800 (PST)
Received: by 10.151.142.12 with HTTP; Mon, 3 Nov 2008 19:33:21 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100027>

I have two projects, both with histories, that I want to merge into
just one library.  I'd like to preserve both histories, perhaps as if
there were two branches being merged into one.  (Although each project
has its own branches that will make the history interesting).

Is there a standard way to do this?

Thanks.
