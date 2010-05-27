From: Vicent Marti <tanoku@gmail.com>
Subject: Libgit2 on the Summer of Code
Date: Thu, 27 May 2010 18:25:32 +0200
Message-ID: <AANLkTil-M3kQGbRZIacItlwr37Lf3lso7FspftLr43_F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, srabbelier@gmail.com
X-From: git-owner@vger.kernel.org Thu May 27 18:32:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHg0K-0003Nz-L3
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 18:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228Ab0E0QcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 12:32:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:60399 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab0E0QcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 12:32:15 -0400
Received: by fg-out-1718.google.com with SMTP id l26so261493fgb.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=Zf94FcaF7M1PznDkKDw3pE7wvbhOfnGvMMs9arHHPJg=;
        b=qvS4eFSMGDBg2FSnbGI2MDkgmiGtE6bBsfF6j3RISTxdYQo6kl1/0zmJFh0R+uTTlj
         oQMli1Zr8P3h7V7oW1toK/fokoosoiyzwxoKEmJ/VNrml5V3QkgvOFyuA6h/nErSAvlw
         YSNdd9wviN2whWsun9hfEqHwnukFyGXO41Yz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=SL/3tj1FmC/+OAak168ZvjHHbTzBx9AzNJklTNw2xq5oMio/8gcgeMevTB0z379iI5
         g9cHIqzXEdlR6JFYrgXG1ntWIJMchMnv3MDzGG5ca/irsdIr4BXpCBtdRKbfI+LPwlLz
         LrY2FFbeB9v24oAZYlp57BFAV6a00nkX1KZU4=
Received: by 10.103.50.17 with SMTP id c17mr397789muk.2.1274977933151; Thu, 27 
	May 2010 09:32:13 -0700 (PDT)
Received: by 10.102.220.12 with HTTP; Thu, 27 May 2010 09:25:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147886>

Hello fine gentlemen,

I believe a short introduction is due. My name is Vicent Marti and I'm
the Google Summer of Code student who will be working on libgit2 this
year. If you haven't heard of it before, libgit2 [1] is a C library
which intents to re implement all of Git's core in a saner, reentrant
manner, with proper error handling and all the usual stuff you'd
expect from an actual library (including a less restrictive license).

I'm being kindly mentored by Scott Chacon on this task, and it seems I
might have been a *tad* too much mentored (;d), because I've spent so
much time discussing things with Scott and the other libgit2
developers that Sverre Rabbelier had to remind me that there's an
actual Git mailing list and I haven't even introduced myself to it
yet.

Well, fear do not. I'm here (a couple weeks late, but here after all)
and although I have been slacking on the community interaction part of
the Summer of Code, the actual project is well under tracks:

All the milestones for the first coding period are mostly finished
(yay for that) and you can find the code and follow my progress on my
public github repo [2]. There is some documentation in place, and
there are some tests in place. In the following days I'll aim for
about 90% code coverage on the tests, to finish the documentation, and
then prepare the patch series for review on this list.

Meanwhile, you are very much welcome to start flaming away before the
patch series are ready. We have roughly one month and a half to fix up
my code to the project's standards; hopefully it won't be *that* bad
and I will be able to implement some extra features before the
evaluation.

Oh, and before I forget, my awesome mentor Scott is writing some Ruby
bindings for the library [3], which at the moment are mostly in-sync
with all the new functionality I've added. Those will come in handy if
you want to try out the new features of Libgit2 with a more friendly
interface... as friendly as Ruby can be, that is. ;/

Thanks for your time, I'm looking forward to your input and I promise
I'll be much more active on this list from now on.

Cheers,
Vicent Mart=ED
http://www.bellverde.org

[1]: http://repo.or.cz/w/libgit2.git
[2]: http://github.com/tanoku/libgit2-gsoc2010
[3]: http://github.com/schacon/ribbit
