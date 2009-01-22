From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Merging adjacent deleted lines?
Date: Thu, 22 Jan 2009 21:13:30 +0100
Message-ID: <200901222113.31082.robin.rosenberg.lists@dewire.com>
References: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com> <7vy6x4cqq1.fsf@gitster.siamese.dyndns.org> <57518fd10901220257p62b6d1efof97ba3fcf90dbfda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 21:15:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ5x6-0003er-6y
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 21:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbZAVUNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 15:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbZAVUNf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 15:13:35 -0500
Received: from mail.dewire.com ([83.140.172.130]:12627 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866AbZAVUNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 15:13:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 835BD80285D;
	Thu, 22 Jan 2009 21:13:32 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G469l87VMoSU; Thu, 22 Jan 2009 21:13:31 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CADE78026F5;
	Thu, 22 Jan 2009 21:13:31 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <57518fd10901220257p62b6d1efof97ba3fcf90dbfda@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106783>

torsdag 22 januari 2009 11:57:41 skrev Jonathan del Strother:
> On Wed, Jan 21, 2009 at 7:49 PM, Robin Rosenberg
> <robin.rosenberg.lists@dewire.com> wrote:
> > onsdag 21 januari 2009 20:20:50 skrev Jonathan del Strother:
> > [...]
> > I think you've illustrated a case for graphical merge resolution tools, i.e.
> > run git mergetool to help resolve the conlicts. It will run a graphical tool
> > for you.
> >
> 
> Mmm.  I use opendiff, which is generally ok, but in this case produced
> a merge looking like this :
> http://pastie.org/paste/asset/367587/Picture_6.png
> Which, in my mind, isn't any clearer about the fact that both lines
> ought to be deleted than the text conflict markers are.  Do any of the
> other graphical tools present conflicts like that differently?

Try a three-way merge tool instead like, e.g. xxdiff.

-- robin
