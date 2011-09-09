From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RFD: leveraging GitHub's asciidoc rendering for our Documentation/
Date: Fri, 09 Sep 2011 17:58:06 +0200
Message-ID: <4E6A378E.6020704@alum.mit.edu>
References: <4E6A23DB.1040606@drmicha.warpmail.net> <CAP2yMaJ+UBHZp0U=QWOZbnbbOuq8vNoJODWtxZPb1sKXTC_UEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 17:58:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23T7-0002w1-4f
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 17:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759151Ab1IIP6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 11:58:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58828 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758581Ab1IIP6L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 11:58:11 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p89Fw7lu015420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 9 Sep 2011 17:58:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <CAP2yMaJ+UBHZp0U=QWOZbnbbOuq8vNoJODWtxZPb1sKXTC_UEg@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181083>

On 09/09/2011 05:45 PM, Scott Chacon wrote:
> On Fri, Sep 9, 2011 at 7:34 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> which has all the renaming (*.txt -> *.asciidoc) and Makefile and script
>> changes, but is missing some include changes (because include breaks
>> anyway, see below).
> 
> I can change this so we can render .asc if that's less ugly.  I've
> been meaning to do this for a while, but I don't think I ever
> incorporated it.

What about letting the project set a gitattribute that tells github how
to render particular files?  It would not require files to be renamed,
and it would be more flexible.

OTOH it would not be possible to apply gitattributes (or file renamings)
to old revisions, so the history would continue to be rendered naively.
 But here's an additional idea: github could provide web access to the
equivalent of $GIT_DIR/info/attributes (a project-wide .gitattributes
file), which would allow the rendering of files in historical revisions
to be customized and would also allow github rendering behavior to be
defined even in projects that do not want github-specific tags in the
.gitattributes files in their project.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
