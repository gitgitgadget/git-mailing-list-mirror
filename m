From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 1/4] glossary: add 'treeish' as a synonym for 'tree-ish'
Date: Wed, 19 Jun 2013 15:12:07 -0400
Message-ID: <51C20287.3060301@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com> <1371607780-2966-2-git-send-email-rhansen@bbn.com> <7vli6610yg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 21:12:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpNnk-0006ce-9B
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 21:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427Ab3FSTMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 15:12:12 -0400
Received: from smtp.bbn.com ([128.33.1.81]:30362 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757414Ab3FSTML (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 15:12:11 -0400
Received: from socket.bbn.com ([192.1.120.102]:39122)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1UpNnc-000PEv-9d; Wed, 19 Jun 2013 15:12:08 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 08EDF3FF5E
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vli6610yg.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228413>

On 2013-06-19 13:09, Junio C Hamano wrote:
> Richard Hansen <rhansen@bbn.com> writes:
> 
>> The documentation contains a mix of the two spellings, and including
>> both makes it possible for users to search the glossary with their
>> spelling of choice.
> 
> Is it an option to instead find dashless form in our documentation
> and turn all of them into tree-ish form with a dash?  I personally
> find it cleaner that way.

I can s/treeish/tree-ish/g, although I'd still like to keep 'treeish' in
the glossary so that people can find it when they search for the
misspelled version.

Perhaps something like:

-[[def_tree-ish]]tree-ish::
+[[def_tree-ish]]tree-ish (sometimes misspelled treeish)::

would be satisfactory?

While we're on the topic, do you have a preference for commit-ish vs.
committish?  Grepping the code shows comittish to be the overwhelming
favorite, but it's inconsistent with tree-ish.

-Richard


> 
>>
>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>> ---
>>  Documentation/glossary-content.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
>> index db2a74d..01365d9 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -486,7 +486,7 @@ should not be combined with other pathspec.
>>  	with refs to the associated blob and/or tree objects. A
>>  	<<def_tree,tree>> is equivalent to a <<def_directory,directory>>.
>>  
>> -[[def_tree-ish]]tree-ish::
>> +[[def_tree-ish]]tree-ish (also treeish)::
>>  	A <<def_ref,ref>> pointing to either a <<def_commit_object,commit
>>  	object>>, a <<def_tree_object,tree object>>, or a <<def_tag_object,tag
>>  	object>> pointing to a tag or commit or tree object.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
