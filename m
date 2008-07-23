From: "Anton Mostovoy" <a@mostovoy.net>
Subject: git svn throws locale related error when built from source
Date: Wed, 23 Jul 2008 11:00:23 -0500
Message-ID: <F06D8607A852466D93AE8BF2AF224893@chi.orbitz.net>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org> <20080722193901.GA5113@blimp.local> <alpine.DEB.1.00.0807222115440.8986@racer> <20080722203128.GB5113@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:02:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLgmN-0000uR-7E
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYGWQA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbYGWQA1
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:00:27 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:46179 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbYGWQA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:00:27 -0400
Received: by an-out-0708.google.com with SMTP id d40so529327and.103
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 09:00:26 -0700 (PDT)
Received: by 10.100.251.5 with SMTP id y5mr246592anh.125.1216828825902;
        Wed, 23 Jul 2008 09:00:25 -0700 (PDT)
Received: from AMOSTOVOYT60 ( [198.175.55.5])
        by mx.google.com with ESMTPS id 43sm9796148wri.27.2008.07.23.09.00.24
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 09:00:25 -0700 (PDT)
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20080722203128.GB5113@blimp.local>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Thread-Index: AcjsOfNYfcm4CrqoT06C29t9bKC2kgAGeF1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89692>

Hi

I built git 1.5.6.3 manually (no package with 1.5.4+ on gutsy), and I am
getting the error below when running 'git svn rebase'. 
svn works fine on its own though.  
The default locale is set to en_US.UTF-8

svn: error: cannot set LC_ALL locale
svn: error: environment variable LANG is en_US.UTF-8
svn: error: please check that your locale name is correct

I found a workaround that works, but it would be nice to have it work
properly.
$> LANG= git svn rebase"

Thanks in advance.
-Anton
