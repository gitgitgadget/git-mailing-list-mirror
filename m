From: Laszlo Papp <lpapp@kde.org>
Subject: git log --follow for directories
Date: Tue, 19 May 2015 14:56:48 +0100
Message-ID: <CAOMwXhP-BRd356xpfdLgZ0zKYTMVryt8jtmi3T2jhVh91hY04Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 19 15:56:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yui0u-0007ik-16
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 15:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbbESN4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 09:56:51 -0400
Received: from mail-vn0-f44.google.com ([209.85.216.44]:37913 "EHLO
	mail-vn0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541AbbESN4t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 09:56:49 -0400
Received: by vnbf190 with SMTP id f190so1114131vnb.5
        for <git@vger.kernel.org>; Tue, 19 May 2015 06:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:content-type;
        bh=m1YZuo9NCPf1w6agBHzoyzx0dlub5cBEXDoFcL9M49M=;
        b=OsfPmm7CIBH9dQhtL72Rrfbh6xp7GCmsWudYkmporVQNMvhhL+eXWEaYDzmu9Xcjsa
         u+XJVJ8JrYzIU4JAkFoj99d8Uwwu5BDb4c2w8WFhwyTQLU+9zGMrEbVFz79/0bPT5bvE
         zRWKsbtHAzzVIxmQ2pvcwfP3Ug91ghpV9DBGyEgZ6wogsdnPelUdvTEwZ1fVup6EIZnf
         RevVW3MaTqIx0KhM3JbVB7K6qki8Q0kqevR5rx9I/N7EazH/LBi5lEvz2e+E2eyvkJPi
         VvSfjdptki46mol1j8LDRU0maqwfgxZwpHHkHHRogEI9NfT62ID7k3vX5BHe/2KrUX1V
         fNFw==
X-Gm-Message-State: ALoCoQltuaeVYKkvDXGd51zjyBNpZhc7QCbMBFjeXG24SdzGsTiE0SEcTv8oZNjvCqyydez9sYO9
X-Received: by 10.52.153.20 with SMTP id vc20mr27562287vdb.64.1432043808467;
 Tue, 19 May 2015 06:56:48 -0700 (PDT)
Received: by 10.53.6.12 with HTTP; Tue, 19 May 2015 06:56:48 -0700 (PDT)
X-Google-Sender-Auth: qwBrlIjNbJduBNAeo_S3Yj0ak44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269357>

Hi,

I have just realized that this would not work on directories
triggering directory renames somewhat pointless for those who want to
keep track of a group of files in directories.

It is unfortunate when you have a directory with many files and more
often than not, you would like to look at the history of all rather
than individually.

Is there any benefit about having it like it is today or is it just
the usual "no one has implemented it yet"?

Cheers, L.

PS.: I will not stand up for implement this though, but of course I
will be very grateful if someone else decides to do so.
