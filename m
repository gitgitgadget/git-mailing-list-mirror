From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: git-bundle question.
Date: Sun, 11 May 2008 17:11:46 -0500
Message-ID: <5d46db230805111511g5bbb0b9amf65fb95266a80504@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 12 00:13:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvJn1-0006Oq-L9
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 00:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbYEKWLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 18:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbYEKWLw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 18:11:52 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:36426 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYEKWLw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 18:11:52 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1161518ywe.1
        for <git@vger.kernel.org>; Sun, 11 May 2008 15:11:46 -0700 (PDT)
Received: by 10.150.82.41 with SMTP id f41mr7489196ybb.169.1210543906256;
        Sun, 11 May 2008 15:11:46 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Sun, 11 May 2008 15:11:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81821>

Hi,

I am writing my wrapper over git bundle and I noticed that the
"SPECIFYING REFERENCES" section says that the it will only
bundle things that end in something git-show-ref can find.

I can probably work around this by silently creating a tag
doing the bundle and deleting the tag, but I want to know why
this restriction is in there in the first place?  If there is a good
reason for it then I will probably just add this info to the
documentation.

Thanks,
Govind.
