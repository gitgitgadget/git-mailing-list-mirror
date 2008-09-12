From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] git-gui: I18n fix sentence parts into full sentences for translation again.
Date: Fri, 12 Sep 2008 12:32:13 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200809121232.14364.stimming@tuhh.de>
References: <200809121117.39407.stimming@tuhh.de> <bb6f213e0809120323l3c18cd32hfde9ef6756593061@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 12:33:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke5xm-0006mH-UD
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbYILKcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYILKcJ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:32:09 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:32926 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbYILKcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 06:32:09 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m8CAW37q025890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 12 Sep 2008 12:32:03 +0200
Received: from [192.168.0.101] (e176218255.adsl.alicedsl.de [85.176.218.255])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m8CAW1hZ021998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Sep 2008 12:32:03 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <bb6f213e0809120323l3c18cd32hfde9ef6756593061@mail.gmail.com>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95697>

Am Freitag, 12. September 2008 12:23 schrieb Alexander Gavrilov:
> On Fri, Sep 12, 2008 at 1:17 PM, Christian Stimming <stimming@tuhh.de> 
wrote:
> >-       set op_question [mc "Force resolution to %s?
> >-Note that the diff shows only conflicting changes.
> >+    set op_question [strcat $targetquestion "\n" \
> >+[mc "Note that the diff shows only conflicting changes.
>
> ...
>
> > -               $target [short_path $current_diff_path]]
> > +               $targetquestion [short_path $current_diff_path]]]
>
> You should remove this $target completely -- there is no %s to match it
> anymore.

Oh - right. Thanks for pointing this out. Please modify the patch accordingly.

Christian
