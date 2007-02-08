From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Thu, 8 Feb 2007 10:22:24 +0000
Message-ID: <200702081022.26423.andyparkins@gmail.com>
References: <200702072138.36787.andyparkins@gmail.com> <e5bfff550702080039l236b1f69o6765b8e2dff3e3c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 11:22:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF6QK-0005VA-HO
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 11:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423176AbXBHKWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 05:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423190AbXBHKWh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 05:22:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:6541 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423176AbXBHKWh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 05:22:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so419929uga
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 02:22:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=okUsJjQgQgs37puJpmvEzEzGqxWiRF7T4E/TtOfKX5vdmNKFsr9ng15J7v0FA8Ht4ypIaObnPehSX8oIQYeEMLRIXzDYH1oMVjehPAKSIYmzML7SHjEu5MRhY3sbsNz0h8hbrl7vCR6uMA5BSomYg8WBeDN07MB3ZcQ9B/70IIM=
Received: by 10.78.183.15 with SMTP id g15mr443335huf.1170930148903;
        Thu, 08 Feb 2007 02:22:28 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id q40sm2852974ugc.2007.02.08.02.22.26;
        Thu, 08 Feb 2007 02:22:27 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <e5bfff550702080039l236b1f69o6765b8e2dff3e3c4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39054>

On Thursday 2007 February 08 08:39, Marco Costalba wrote:

> Regarding "Monospace" it should be changeable with Settings menu and
> should apply _only_ to fixed space font viewers, in our case only
> patch viewer and file content viewer.

Incidentally, regarding monospaced fonts and Qt.  While developing these 
patches I noticed that Qt::convertFromPlainText() swallows leading white 
space from the lines.  I dropped it and used a style sheet to set the font 
instead; but in case you use it elsewhere I thought you might be interested.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
