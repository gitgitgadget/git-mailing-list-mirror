From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Git with Lader logic
Date: Wed, 18 Mar 2015 18:38:04 -0400
Message-ID: <00dd01d061cc$33427380$99c75a80$@nexbridge.com>
References: <5F9B9EBF-CD4D-42A8-8A0C-9806702231A1@icloud.com>	<00bd01d061b5$331874c0$99495e40$@nexbridge.com> <CAEtYS8R6xz3vMD72h_j0R6W=FRfY7SjMi-q9z+qfKhqoq5ExCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Bharat Suvarna'" <bharat.bs84@icloud.com>,
	"'Git List'" <git@vger.kernel.org>
To: "'Doug Kelly'" <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:38:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYMbT-0000rk-Qb
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 23:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbbCRWiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 18:38:13 -0400
Received: from elephants.elehost.com ([216.66.27.132]:22220 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbbCRWiN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 18:38:13 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t2IMc7D3086143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Mar 2015 18:38:07 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <CAEtYS8R6xz3vMD72h_j0R6W=FRfY7SjMi-q9z+qfKhqoq5ExCg@mail.gmail.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGgj0ZsDH/SCESknr0YCLhOqCeapgGWkmZBApjFCVSdYP38YA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265769>

On March 18, 2015 6:29 PM Doug Kelly wrote:
> On Wed, Mar 18, 2015 at 2:53 PM, Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> > On March 17, 2015 7:34 PM, Bharat Suvarna wrote:
> >> I am trying to find a way of using version control on PLC programmers
> >> like
> > Allen
> >> Bradley PLC. I can't find a way of this.
> >>
> >> Could you please give me an idea if it will work with Plc programs.
> >> Which
> > are
> >> basically Ladder logic.
> >
> > Many PLC programs either store their project code in XML, L5K or L5X
> > (for example), TXT, CSV, or some other text format or can import and
> > export to text forms. If you have a directory structure that
> > represents your project, and the file formats have reasonable line
> > separators so that diffs can be done easily, git very likely would
> > work out for you. You do not have to have the local .git repository in
> > the same directory as your working area if your tool has issues with
> > that or .gitignore. You may want to use a GUI client to manage your
> > local repository and handle the commit/push/pull/merge/rebase
> > functions as I expect whatever PLC system you are using does not have git
> built-in.
> >
> > To store binary PLC data natively, which some tools use, I expect that
> > those who are better at git-conjuring than I, could provide guidance
> > on how to automate binary diffs for your tool's particular file format.
> 
> The one thing I find interesting about RSLogix in general (caveat: I only have
> very limited experience with RSLogix 500 / 5000; if I do anything nowadays, it's
> in the micro series using RSLogix Micro Starter Lite)... they do have some
> limited notion of version control inside the application itself, though it seems
> rudimentary to me.
> This could prove to be helpful or extremely annoying, since even when I
> connect to a PLC and go online, just to reset the RTC, it still prompts me to save
> again (even though nothing changed, other than the processor state).
> 
> You may also find this link on stackexchange helpful:
> http://programmers.stackexchange.com/questions/102487/are-there-
> realistic-useful-solutions-for-source-control-for-ladder-logic-program
> 
> As Randall noted, L5K is just text, and RSLogix 5000 uses it, according to this
> post.  It may work okay.

A really good reason to use git instead of some other systems is that new versions of files are determined by SHA signatures (real differences) rather than straight timestamps. So saving a file that has not changed will not force a new version - unlike some systems that shall remain nameless.
