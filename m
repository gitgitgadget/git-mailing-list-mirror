From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit4 segfault
Date: Sat, 17 Feb 2007 08:14:56 +0100
Message-ID: <e5bfff550702162314t36fa557dh77eca0ed1215d39@mail.gmail.com>
References: <cc723f590702151108u1bb8e9e8se72e9f216a23d2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 17 08:15:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIJme-0004HX-W0
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 08:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946452AbXBQHO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 02:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946453AbXBQHO6
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 02:14:58 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:48659 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946452AbXBQHO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 02:14:57 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1112731wxd
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 23:14:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dv6RXv1WjCvliiRk+3UuAV/q8LjIBlr04F9OccqPg3IyB+AaufAQibDGVGdn9dX7R25iakvgathdsPdZiHz9jWen3mkZbC2QgudxkIq1QcRWIFJlYDAlTUH3vT+QNmaxaeDch0AyuF7g1KO6O/8rNVvqCQJiUcrC3x8FdcQkBV0=
Received: by 10.115.60.1 with SMTP id n1mr2286813wak.1171696496362;
        Fri, 16 Feb 2007 23:14:56 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Fri, 16 Feb 2007 23:14:56 -0800 (PST)
In-Reply-To: <cc723f590702151108u1bb8e9e8se72e9f216a23d2f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39972>

On 2/15/07, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> on a linux-2.6 repo it fails during exit
>
> Done.
> QProcess: Destroyed while process is still running.
> Segmentation fault (core dumped)

Patch pushed. Should be fixed now.


   Marco
