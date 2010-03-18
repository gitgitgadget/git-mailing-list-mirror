From: bruno le hyaric <bruno.lehyaric@gmail.com>
Subject: How to start well for a special git construction
Date: Thu, 18 Mar 2010 20:26:53 +0100
Message-ID: <e8be804e1003181226y20328151s75641f4341ca12d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 20:27:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLNC-0007bf-2F
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab0CRT04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:26:56 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:59674 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab0CRT0z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 15:26:55 -0400
Received: by bwz1 with SMTP id 1so2374144bwz.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=mXH+FN+y4jyarf5T2W59LQ+hNL77GI1yJNQ2sQLatss=;
        b=kRWHP1gBBzRI7tAnKDwp4AtsV/tUmrAZF0ohCVosE7BrT502kG5RQfXO9q/tWU5dfh
         nqE3kCVpEjfLn+fSiG+rMkasmCJ5q6V/p02P2d7WAQMfqnxnA5nqzEu2z3omNbyUP4ZJ
         jmFQKVeTxDqUpZ8S+/+OWeOyGq1syVNNS2Wj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=FZRZWsR1KM0LjT2xtDbCIlw0MxLqwV4e8Rt5KUHExtAB6vxQCTwgPeaFzQzmOmpNCe
         R9rZ/Cmrd2NMI6sBBuvvcxEmjzmiq+dKhwtk8Q+OjuhKNXvB3MuphsU2ePMoAJ1501AU
         tC7WuutFy9jVFrmONjcDmI69Vt8T/wKrBSypE=
Received: by 10.204.156.22 with SMTP id u22mr3151974bkw.24.1268940413599; Thu, 
	18 Mar 2010 12:26:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142500>

Hi,

I'm working on an e-commerce development project based on Ruby on Rails.



On the left hand, I use one framework : Spree ;
on the other hand , I use Flex generation with another framework : RestfulX;
on my third hand ^^, I want to merge both in a third directory.

Basically, my root folder contains one directory for each : ./spree,
./restfulx, ./merge



The merge is a bit special, because Spree is a framework wich provide
extension feature, and Spree extensions are located in
./spree/vendor/extensions/extension_name. I want to merge resttfulx
folder as a spree extension (I heard about git-module, is this the
good way to solve my problem?)



Moreover, in both folder ./spree and ./restfulx I wan't to manage all
files with git (except databases and logs), but in ./restfulx there
are only few files I need to merge in ./merge. Those files are the
result of code generation from RestfulX. So I think I have to use
branch, one with all files, one which only contains files to 'deliver'
in ./merge.

In my current vision of git, I think branches are used for parallel
developments and are merged together after. In other words, in my
company I'm used to use ClearCase, and to have a development stream,
an integration stream and a release one, in the release stream, we
only deliver executable files, not all source code... I don't know if
Git branches can be seen as Clearcase streams...



Actually, I'm not in the company and I try to build the same
development process automated with git with framework installation
(Spree), code generation (RestfulX) and integration (./merge).

Any advice on how to start will be very helpful.
Do I need several repositories?
Can I use Git-plugins to integrate ./restfulx at a special location in ./merge?
Can I merge only specific files from a repository?


Best regards,

Bruno.

---------------------------------------------------------------------------
----------------------------------------------------------
Spree mailing list, this topic :
http://groups.google.com/group/spree-user/browse_thread/thread/4797e4...
RestfulX mailing list, this topic :
http://groups.google.com/group/restfulx-framework/browse_thread/threa...
